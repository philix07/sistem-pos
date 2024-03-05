import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/presentation/history/removed_history_page.dart';
import 'package:kerja_praktek/frontend/presentation/history/success_history_page.dart';

// This page will display "Today's Order History" and "Report based on month/year"
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _buttonIndex = ValueNotifier(0);

  void onButtonTap(int index) {
    setState(() {
      _buttonIndex.value = index;
    });
  }

  @override
  void initState() {
    context.read<HistoryBloc>().add(HistoryFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _buttonIndex,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  title: "Success",
                  isActive: _buttonIndex.value == 0,
                  onTap: () {
                    onButtonTap(0);
                  },
                ),
                AppButton(
                  title: "Removed",
                  isActive: _buttonIndex.value == 1,
                  onTap: () {
                    onButtonTap(1);
                  },
                ),
              ],
            ),
          ),
          const SpaceHeight(10.0),
          _buttonIndex.value == 0
              ? const SuccessHistoryPage()
              : const RemovedHistoryPage()
        ],
      ),
    );
  }
}
