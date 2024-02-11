import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width = 140,
    this.height = 40,
    this.isActive = false,
  });

  final double width;
  final double height;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primary : AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: AppColor.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Text(
          title,
          style: isActive
              ? AppTextStyle.white(fontSize: 14.0)
              : AppTextStyle.blue(fontSize: 14.0),
        ),
      ),
    );
  }
}
