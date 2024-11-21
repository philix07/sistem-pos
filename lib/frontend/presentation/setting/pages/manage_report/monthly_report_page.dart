import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:kerja_praktek/frontend/blocs/report/report_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_card.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:kerja_praktek/frontend/common/utils/pdf_generator.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/order_empty.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/report_card.dart';
import 'package:kerja_praktek/models/chart_data.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';
import 'package:kerja_praktek/models/report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyReportPage extends StatefulWidget {
  const MonthlyReportPage({super.key});

  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  DateTime selectedDate = DateTime.now();

  Future<DateTime?> showDatePicker() async {
    DateTime? selectedDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.white.withOpacity(0.1),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.dmy,
                    mode: CupertinoDatePickerMode.monthYear,
                    use24hFormat: true,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: AppButton(
                    title: 'Done',
                    onTap: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    var reportBloc = context.read<ReportBloc>();
    reportBloc.add(ReportClearOrderList());

    return AppScaffold(
      child: Column(
        children: [
          //* datetime picker
          InkWell(
            onTap: () async {
              var dateTime = await showDatePicker();
              if (dateTime != null) {
                setState(() {
                  selectedDate = dateTime;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${AppFormatter.monthYear(selectedDate)}'s Report",
                      style: AppTextStyle.black(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SpaceWidth(3.0),
                  const Flexible(
                    child: Icon(
                      IconlyLight.calendar,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SpaceHeight(15.0),

          Expanded(
            child: BlocBuilder<ReportBloc, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ReportError) {
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => AppDialog.show(
                      context,
                      iconPath: 'assets/icons/error.svg',
                      message: state.message,
                    ),
                  );
                } else if (state is ReportEmpty) {
                  return const OrderEmpty();
                } else if (state is ReportSuccess) {
                  var reportModel = reportSummarizer(state.orders);

                  final List<ChartData> chartData = [
                    ChartData(x: 'Makanan', y: reportModel.foodsSold),
                    ChartData(x: 'Minuman', y: reportModel.drinksSold),
                    ChartData(x: 'Snack', y: reportModel.snacksSold),
                  ];

                  return Column(
                    children: [
                      SfCircularChart(
                        legend: const Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                        ),
                        // title: const ChartTitle(text: 'Laporan Penjualan'),
                        series: <CircularSeries>[
                          // Render pie chart
                          PieSeries<ChartData, String>(
                            dataSource: chartData,
                            pointColorMapper: (ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                            radius: '60%',
                          )
                        ],
                      ),
                      Expanded(
                        child: ReportSummarizeCard(items: state.orders),
                      ),
                      const SpaceHeight(5.0),
                      AppCard(
                        child: Text(
                          'Total Pendapatan : Rp ${AppFormatter.number(reportModel.totalRevenue)}',
                          style: AppTextStyle.black(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),

          const SpaceHeight(10.0),

          //* footer buttons
          BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              if (state is ReportSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      title: 'Get Data',
                      isActive: true,
                      onTap: () {
                        reportBloc.add(ReportFetchMonthlyOrder(
                          month: selectedDate.month,
                          year: selectedDate.year,
                        ));
                      },
                    ),
                    //! Report Belum Dibuat
                    AppButton(
                      title: 'Download PDF',
                      onTap: () {
                        String dateInterval =
                            "Bulan ${selectedDate.month} Tahun ${selectedDate.year}";

                        AppPdfGenerator pdfGenerator = AppPdfGenerator();
                        pdfGenerator.createPDF(
                          reportSummarizer(state.orders),
                          dateInterval,
                        );
                      },
                    ),
                  ],
                );
              }

              //* any state other than success
              return AppButton(
                title: 'Get Data',
                isActive: true,
                onTap: () {
                  reportBloc.add(ReportFetchMonthlyOrder(
                    month: selectedDate.month,
                    year: selectedDate.year,
                  ));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  ReportModel reportSummarizer(List<OrderItem> orderItems) {
    int foodsSold = 0;
    int drinksSold = 0;
    int snacksSold = 0;
    int totalRevenue = 0;

    orderItems.forEach(((item) {
      if (item.product.category == ProductCategory.food) {
        foodsSold += item.quantity;
      } else if (item.product.category == ProductCategory.drink) {
        drinksSold += item.quantity;
      } else if (item.product.category == ProductCategory.snack) {
        snacksSold += item.quantity;
      }

      totalRevenue += item.product.price * item.quantity;
    }));

    return ReportModel(
      foodsSold: foodsSold,
      drinksSold: drinksSold,
      snacksSold: snacksSold,
      totalRevenue: totalRevenue,
      items: orderItems,
    );
  }

}
