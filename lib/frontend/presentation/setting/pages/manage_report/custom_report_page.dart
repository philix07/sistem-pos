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

class CustomReportPage extends StatefulWidget {
  const CustomReportPage({super.key});

  @override
  State<CustomReportPage> createState() => _CustomReportPageState();
}

class _CustomReportPageState extends State<CustomReportPage> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<DateTime?> _showDatePicker() async {
    var dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    var reportBloc = context.read<ReportBloc>();
    reportBloc.add(ReportClearOrderList());

    return AppScaffold(
      child: Column(
        children: [
          //* row that handles date time picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  var dateTime = await _showDatePicker();
                  if (dateTime != null) {
                    setState(() {
                      _startDate = dateTime;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  width: MediaQuery.of(context).size.width / 2.5,
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
                          AppFormatter.dmy(_startDate),
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
              Text(
                '-----',
                style: AppTextStyle.black(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () async {
                  var dateTime = await _showDatePicker();
                  if (dateTime != null) {
                    setState(() {
                      _endDate = dateTime;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  width: MediaQuery.of(context).size.width / 2.5,
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
                          AppFormatter.dmy(_endDate),
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
            ],
          ),
          const SpaceHeight(5.0),

          //* history content
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
                        reportBloc.add(ReportFetchCustomOrder(
                          startDate: _startDate,
                          endDate: _endDate,
                        ));
                      },
                    ),
                    //! Report Belum Dibuat
                    AppButton(
                      title: 'Download PDF',
                      onTap: () {
                        String dateInterval =
                            "${AppFormatter.dmy(_startDate)} s/d ${AppFormatter.dmy(_endDate)}";

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
                  reportBloc.add(ReportFetchCustomOrder(
                    startDate: _startDate,
                    endDate: _endDate,
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
