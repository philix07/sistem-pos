import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/presentation/admin/add_product_page.dart';
import 'package:kerja_praktek/frontend/presentation/admin/edit_product_page.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const AppBackBar(title: "Manage Item Page"),
          Expanded(
            child: AppIconButton(
              width: double.maxFinite,
              isRow: false,
              isBlue: true,
              isSvg: true,
              iconPath: "assets/icons/add.svg",
              title: "Add Product",
              fontSize: 24,
              svgWidth: 100,
              svgHeight: 100,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductPage(),
                  ),
                );
              },
            ),
          ),
          const SpaceHeight(10.0),
          Expanded(
            child: AppIconButton(
              width: double.maxFinite,
              isRow: false,
              isBlue: true,
              isSvg: true,
              iconPath: "assets/icons/repair-tool.svg",
              title: "Edit Product",
              fontSize: 24,
              svgWidth: 100,
              svgHeight: 100,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProductPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
