import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/search_input.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/category_button.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _categoryIndex = ValueNotifier(0);

  void onCategoryTap(int index) {
    setState(() {
      _categoryIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Katalog",
          style: AppTextStyle.blue(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      child: Column(
        children: [
          SearchInput(
            title: "Search",
            onChanged: (val) {},
          ),
          const SpaceHeight(20.0),
          ValueListenableBuilder(
            valueListenable: _categoryIndex,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  iconPath: 'assets/icons/all_categories.svg',
                  label: "Semua",
                  isActive: _categoryIndex.value == 0,
                  onPressed: () => onCategoryTap(0),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/food.svg',
                  label: "Makanan",
                  isActive: _categoryIndex.value == 1,
                  onPressed: () => onCategoryTap(1),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/drink.svg',
                  label: "Minuman",
                  isActive: _categoryIndex.value == 2,
                  onPressed: () => onCategoryTap(2),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/snack.svg',
                  label: "Snack",
                  isActive: _categoryIndex.value == 3,
                  onPressed: () => onCategoryTap(3),
                ),
              ],
            ),
          ),
          Expanded(
            child: ProductEmpty(),
          )
        ],
      ),
    );
  }
}
