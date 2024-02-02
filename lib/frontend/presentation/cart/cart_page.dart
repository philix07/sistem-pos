import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [Text('Cart')],
      ),
    );
  }
}
