import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/report/report_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/presentation/setting/pages/manage_report/custom_report_page.dart';
import 'package:kerja_praktek/frontend/presentation/setting/pages/manage_report/monthly_report_page.dart';
import 'package:kerja_praktek/frontend/presentation/setting/pages/manage_report/yearly_report_page.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';
import 'package:kerja_praktek/models/report.dart';

class ManageReportPage extends StatefulWidget {
  const ManageReportPage({super.key});

  @override
  State<ManageReportPage> createState() => _ManageReportPageState();
}

class _ManageReportPageState extends State<ManageReportPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      context.read<ReportBloc>().add(ReportClearOrderList());
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: 'Laporan Keuangan',
      bottom: TabBar(
        controller: tabController,
        tabs: const [
          Tab(child: Text('Custom')),
          Tab(child: Text('Bulanan')),
          Tab(child: Text('Tahunan')),
        ],
        unselectedLabelColor: AppColor.disabled,
        labelColor: AppColor.primary,
      ),
      child: TabBarView(
        controller: tabController,
        children: const [
          CustomReportPage(),
          MonthlyReportPage(),
          YearlyReportPage(),
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
