import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/history_section.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/report_section.dart';

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
                  title: "History",
                  isActive: _buttonIndex.value == 0,
                  onTap: () {
                    onButtonTap(0);
                  },
                ),
                AppButton(
                  title: "Report",
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
              ? const HistorySection()
              : const ReportSection()
        ],
      ),
    );
  }
}
