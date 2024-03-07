import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class TextDescripton extends StatelessWidget {
  const TextDescripton({
    super.key,
    required this.title,
    required this.subtitle,
    this.fontSize = 16,
    this.gap = 5.0,
  });

  final String title;
  final String subtitle;
  final double fontSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: AppTextStyle.blue(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SpaceHeight(gap),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            subtitle,
            style: AppTextStyle.black(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SpaceHeight(gap),
        const Divider(
          height: 1,
          color: Colors.black,
          thickness: 0.5,
        ),
      ],
    );
  }
}
