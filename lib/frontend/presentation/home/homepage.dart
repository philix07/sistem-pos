import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/search_input.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/home/models/product_category.dart';
import 'package:kerja_praktek/frontend/presentation/home/models/product_model.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/category_button.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/product_card.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _categoryIndex = ValueNotifier(0);

  var productsExample = [
    ProductModel(
      image: 'No Image yet',
      name: 'Pangsit Yang Sangat Sangat Besar',
      category: ProductCategory.food,
      price: 1200000,
      stock: 20,
    ),
    ProductModel(
      image: 'No Image yet',
      name: 'Lobak Yang Sangat Sangat Besar',
      category: ProductCategory.snack,
      price: 120000,
      stock: 20,
    ),
    ProductModel(
      image: 'No Image yet',
      name: 'Wortel Yang Sangat Sangat Besar',
      category: ProductCategory.drink,
      price: 50000,
      stock: 20,
    )
  ];

  void onCategoryTap(int index) {
    setState(() {
      _categoryIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return AppScaffold(
      child: Column(
        children: [
          SearchInput(
            controller: searchController,
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
          const SpaceHeight(12.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: productsExample.length,
              itemBuilder: (context, index) => ProductCard(
                data: productsExample[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
