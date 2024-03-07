// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.title,
    required this.iconPath,
    required this.controller,
    required this.inputFormatters,
    this.width = double.maxFinite,
    this.height = 70,
    this.obscureText = false,
    this.validator,
  });

  final String title;
  final String iconPath;
  final double width;
  final double height;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputFormatter inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: [inputFormatters],
        validator: validator,
        obscureText: obscureText,
        style: AppTextStyle.black(fontSize: 12.0, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          fillColor: AppColor.white,
          filled: true,
          errorMaxLines: 1,
          prefixIcon: Container(
            margin: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: const ColorFilter.mode(
                AppColor.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints.loose(const Size(50, 50)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          label: Text(
            title,
            style: AppTextStyle.black(fontWeight: FontWeight.w700),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.black,
              width: 3.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            gapPadding: 4.0,
          ),
        ),
      ),
    );
  }
}
