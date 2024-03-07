import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/printer_button.dart';

class ManagePrinterPage extends StatefulWidget {
  const ManagePrinterPage({super.key});

  @override
  State<ManagePrinterPage> createState() => _ManagePrinterPageState();
}

class _ManagePrinterPageState extends State<ManagePrinterPage> {
  var buttonIndex = ValueNotifier(0);
  void onButtonTap(int index) {
    setState(() {
      buttonIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const AppBackBar(title: 'Kelola Printer'),
          //* Use Row To Constraint The Width
          //* Taking As Less Width As Possible
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.disabled,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5.0,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      color: AppColor.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: buttonIndex,
                  builder: (context, value, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrinterButton(
                        title: 'Search',
                        isActive: buttonIndex.value == 0,
                        onTap: () => onButtonTap(0),
                      ),
                      PrinterButton(
                        title: 'Disconnect',
                        isActive: buttonIndex.value == 1,
                        onTap: () => onButtonTap(1),
                      ),
                      PrinterButton(
                        title: 'Test',
                        isActive: buttonIndex.value == 2,
                        onTap: () => onButtonTap(2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
