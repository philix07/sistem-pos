import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/history_empty_card.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/success_history_card.dart';

class SuccessHistoryPage extends StatelessWidget {
  const SuccessHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistorySuccess) {
          var successOrder = state.orders
              .where((orderModel) => orderModel.isDeleted == false)
              .toList();

          if (successOrder.isEmpty) {
            return const HistoryEmptyCard();
          } else {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: successOrder.length,
                itemBuilder: (context, index) => SuccessHistoryCard(
                  orderModel: successOrder[index],
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
