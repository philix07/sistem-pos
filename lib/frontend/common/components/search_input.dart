import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.onChanged,
    this.readOnly = false,
    this.title = "Search",
    required this.controller,
  });

  final String title;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: AppTextStyle.gray(
            fontSize: 16.0,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColor.primary,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
