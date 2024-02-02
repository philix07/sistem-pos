import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';

class AppTextStyle {
  static TextStyle black({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.font,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle blue({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.primary,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle gray({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.disabled,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }
}
