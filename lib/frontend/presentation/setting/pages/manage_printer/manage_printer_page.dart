import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class ManagePrinterPage extends StatefulWidget {
  const ManagePrinterPage({super.key});

  @override
  State<ManagePrinterPage> createState() => _ManagePrinterPageState();
}

class _ManagePrinterPageState extends State<ManagePrinterPage> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  bool isConnected = false;

  @override
  void initState() {
    getDevices();
    super.initState();
  }

  Future<void> getDevices() async {
    //! Uncomment only when using on real device
    devices = await printer.getBondedDevices();
    setState(() {});
  }

  Future<void> checkPrinterConnection() async {
    var connected = await printer.isConnected;
    setState(() {
      isConnected = connected!;
    });
  }

  Future<void> testPrinting() async {
    if ((await printer.isConnected)!) {
      printer.printNewLine();

      // SIZE
      // 0 : Normal
      // 1 : Normal - Bold
      // 2 : Medium - Bold
      // 3 : Large  - Bold

      // ALIGN
      // 0 : Left
      // 1 : Center
      // 2 : Right

      printer.printCustom('Thermal Printer Demo', 0, 1);
      printer.printNewLine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: 'Kelola Printer',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //* Select Devices
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.75,
            child: DropdownButton(
              value: selectedDevice,
              padding: const EdgeInsets.all(10.0),
              hint: const Text('Pilih Perangkat'),
              isExpanded: true,
              items: devices
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name!),
                      ))
                  .toList(),
              onChanged: (device) {
                setState(() {
                  selectedDevice = device;
                });
              },
            ),
          ),

          //* Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(
                width: MediaQuery.of(context).size.width / 4,
                title: 'Connect',
                onTap: () async {
                  if (selectedDevice != null) {
                    const CircularProgressIndicator();
                    await printer.connect(selectedDevice!);
                    await checkPrinterConnection();
                  }
                },
              ),
              AppButton(
                width: MediaQuery.of(context).size.width / 4,
                title: 'Disconnect',
                onTap: () async {
                  bool? isConnected = await printer.isConnected;
                  if (isConnected!) {
                    const CircularProgressIndicator();
                    await printer.disconnect();
                  }
                  await checkPrinterConnection();
                },
              ),
              AppButton(
                width: MediaQuery.of(context).size.width / 4,
                title: 'Test',
                onTap: () {
                  //* Test Printing Something
                  testPrinting();
                },
              ),
            ],
          ),
          const SpaceHeight(15.0),

          isConnected == false
              ? Text(
                  'Tidak Ada Perangkat Terhubung',
                  style: AppTextStyle.black(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Text(
                  'Perangkat Terhubung : ${selectedDevice!.name}',
                  style: AppTextStyle.black(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ],
      ),
    );
  }
}
