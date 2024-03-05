import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/history_empty_card.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/removed_history_card.dart';

class RemovedHistoryPage extends StatelessWidget {
  const RemovedHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistorySuccess) {
          var removedOrder = state.orders
              .where((orderModel) => orderModel.isDeleted == true)
              .toList();

          if (removedOrder.isEmpty) {
            return const HistoryEmptyCard();
          } else {
            return Expanded(
              // child: GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     childAspectRatio: 0.9,
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 12.0,
              //     mainAxisSpacing: 12.0,
              //   ),
              //   itemCount: removedOrder.length,
              //   itemBuilder: (context, index) => RemovedHistoryCard(
              //     orderModel: removedOrder[index],
              //   ),
              // ),
              //! Try to use ListView
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: removedOrder.length,
                itemBuilder: (context, index) => RemovedHistoryCard(
                  orderModel: removedOrder[index],
                ),
              ),
            );
          }
        } else if (state is HistoryError) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () => AppDialog.show(
              context,
              iconPath: 'assets/icons/error.svg',
              message: state.message,
            ),
          );
        }
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
