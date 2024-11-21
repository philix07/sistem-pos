import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/form_validator.dart';
import 'package:kerja_praktek/frontend/presentation/history/removed_history_page.dart';
import 'package:kerja_praktek/frontend/presentation/history/success_history_page.dart';
import 'package:kerja_praktek/models/user.dart';

// This page will display "Today's Order History" and "Report based on month/year"
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late AppUser appUser;

  @override
  void initState() {
    appUser = context.read<AuthBloc>().appUser;
    context.read<HistoryBloc>().add(HistoryFetch());
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  bool canAccessRemovedOrder(UserRole role) {
    if (role == UserRole.supervisor || role == UserRole.owner) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: 'Transaction History',
      bottom: TabBar(
        controller: tabController,
        tabs: const [
          Tab(child: Text('Success')),
          Tab(child: Text('Removed')),
        ],
        unselectedLabelColor: AppColor.disabled,
        labelColor: AppColor.primary,
      ),
      child: TabBarView(
        controller: tabController,
        children: [
          const SuccessHistoryPage(),
          canAccessRemovedOrder(appUser.role)
              ? const RemovedHistoryPage()
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    "You Don't Have Access To This Page",
                    style: AppTextStyle.red(fontSize: 14.0),
                  ),
                ),
        ],
      ),
    );
  }
}
