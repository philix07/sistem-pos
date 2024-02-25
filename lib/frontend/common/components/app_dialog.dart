import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AppDialog {
  static void show(
    BuildContext context, {
    required String iconPath,
    required String message,
    Color contentColor = Colors.redAccent,
    double iconWidth = 70,
    double iconHeight = 70,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpaceHeight(20.0),
            SvgPicture.asset(
              iconPath,
              width: iconWidth,
              height: iconHeight,
              colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
            ),
            const SpaceHeight(10.0),
            Text(
              message,
              style: GoogleFonts.openSans(
                color: contentColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                textStyle: const TextStyle(overflow: TextOverflow.visible),
              ),
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Back',
              style: AppTextStyle.black(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
