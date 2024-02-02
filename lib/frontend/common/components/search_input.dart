import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key, required this.title, this.onChanged});

  final String title;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(
          title,
          style: AppTextStyle.black(fontSize: 16.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColor.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColor.lightBlue),
        ),
        icon: const Icon(Icons.search_rounded, color: AppColor.lightBlue),
      ),
    );
  }
}
