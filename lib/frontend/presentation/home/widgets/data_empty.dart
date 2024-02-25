import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/shopping_cart.svg',
            height: 120,
            width: 120,
            colorFilter: const ColorFilter.mode(
              AppColor.disabled,
              BlendMode.srcIn,
            ),
          ),
          const SpaceHeight(15.0),
          Text(
            title,
            style: AppTextStyle.gray(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
