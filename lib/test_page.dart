import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  DateTime now = DateTime.now();
  DateTime oneHourAgo = DateTime.now().subtract(Duration(hours: 1));
  DateTime oneDayAgo = DateTime.now().subtract(Duration(days: 1));
  DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
  DateTime oneMonthAgo = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
  );

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData(AppFormatter.dateTime(oneMonthAgo), 40),
      _SalesData(AppFormatter.dateTime(oneWeekAgo), 32),
      _SalesData(AppFormatter.dateTime(oneDayAgo), 34),
      _SalesData(AppFormatter.dateTime(oneHourAgo), 28),
      _SalesData(AppFormatter.dateTime(now), 35),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Column(
        children: [
          //Initialize the chart widget
          SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            // Chart title
            title: const ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: const Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  alignment: ChartAlignment.near,
                  labelAlignment: ChartDataLabelAlignment.bottom,
                ),
              )
            ],
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: const SparkChartTrackball(
          //         activationMode: SparkChartActivationMode.tap,
          //       ),
          //       //Enable marker
          //       marker: const SparkChartMarker(
          //         displayMode: SparkChartMarkerDisplayMode.all,
          //       ),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].year,
          //       yValueMapper: (int index) => data[index].sales,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
