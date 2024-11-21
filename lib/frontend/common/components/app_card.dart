import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 6.0,
            blurStyle: BlurStyle.outer,
            color: AppColor.black.withOpacity(0.2),
          ),
        ],
      ),
      child: child,
    );
  }
}
