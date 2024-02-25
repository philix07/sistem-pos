import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/admin/manage_product_page.dart';
import 'package:kerja_praktek/frontend/presentation/admin/widget/text_description.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpaceHeight(10.0),
          const TextDescripton(title: "NAME", subtitle: "Felix Liando"),
          const SpaceHeight(30.0),
          const TextDescripton(title: "YOUR ROLE", subtitle: "Cashier"),
          const SpaceHeight(30.0),
          Expanded(child: Container()),
          AppIconButton(
            title: "Manage Product",
            width: double.infinity,
            isSvg: true,
            iconPath: 'assets/icons/all_categories.svg',
            isBlue: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManageProductPage()),
              );
            },
          ),
          const SpaceHeight(10.0),
          AppIconButton(
            title: "Manage Printer",
            width: double.infinity,
            isSvg: true,
            iconPath: 'assets/icons/print.svg',
            isBlue: true,
            onTap: () {},
          ),
          const SpaceHeight(10.0),
          AppIconButton(
            title: "Report",
            width: double.infinity,
            isSvg: true,
            iconPath: 'assets/icons/financial_report.svg',
            isBlue: true,
            onTap: () {},
          ),
          const SpaceHeight(10.0),
          AppIconButton(
            title: "Logout",
            width: double.infinity,
            isSvg: true,
            iconPath: 'assets/icons/logout.svg',
            isBlue: true,
            onTap: () {},
          ),
          const SpaceHeight(10.0),
          AppIconButton(
            title: "Dialog Testing",
            width: double.infinity,
            isSvg: true,
            iconPath: 'assets/icons/logout.svg',
            isBlue: false,
            onTap: () {
              AppDialog.show(
                context,
                iconPath: 'assets/icons/error.svg',
                message: "Data Not Found",
              );
            },
          ),
        ],
      ),
    );
  }
}
