import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class PrinterButton extends StatelessWidget {
  const PrinterButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColor.white : AppColor.disabled,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: InkWell(
        onTap: onTap,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: isActive
                ? AppTextStyle.blue(fontWeight: FontWeight.w700)
                : AppTextStyle.black(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
