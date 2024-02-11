import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/components/test_dialog.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                title: "Tunai",
                onTap: () {},
              ),
              const SpaceWidth(3),
              AppButton(
                title: "Transfer",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
