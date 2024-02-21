import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class TextDescripton extends StatelessWidget {
  const TextDescripton({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.blue(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SpaceHeight(5.0),
        Text(
          subtitle,
          style: AppTextStyle.black(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SpaceHeight(5.0),
        const Divider(
          height: 1,
          color: Colors.black,
          thickness: 0.5,
        ),
      ],
    );
  }
}
