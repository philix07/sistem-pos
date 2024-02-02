import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final double size;

  const CategoryButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.isActive = false,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: Container(
          width: size,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isActive ? AppColor.primary : AppColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 20.0,
                blurStyle: BlurStyle.outer,
                spreadRadius: 0,
                color: AppColor.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColor.white : AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SpaceHeight(10.0),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColor.white : AppColor.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
