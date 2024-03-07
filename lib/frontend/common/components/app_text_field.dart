import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.inputFormatter,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.height = 50,
    this.width = double.maxFinite,
    this.fontSize = 14,
    
  });

  final TextEditingController controller;
  final bool enabled;
  final bool readOnly;
  final String labelText;
  final double width;
  final double height;
  final double fontSize;
  final String? Function(String?)? validator;
  final TextInputFormatter inputFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        validator: validator,
        //TODO: Tambahkan text input formatter

        inputFormatters: [inputFormatter],
        style: AppTextStyle.black(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          contentPadding: const EdgeInsets.all(12.0),
          enabled: enabled,
          fillColor: AppColor.disabled.withOpacity(0.4),
          filled: true,
          alignLabelWithHint: true,
          hintText: labelText,
          hintStyle: AppTextStyle.gray(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
