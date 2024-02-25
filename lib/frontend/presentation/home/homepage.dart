import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/data/services/product_services.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/search_input.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/home/bloc/product/product_bloc.dart';
import 'package:kerja_praktek/models/product.dart';
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

  @override
  void initState() {
    context.read<ProductBloc>().add(FetchAll());
    super.initState();
  }

  void onCategoryTap(int index, {required ProductCategory category}) {
    setState(() {
      _categoryIndex.value = index;
    });

    context.read<ProductBloc>().add(FetchByCategory(category: category));
  }

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    // var productBloc = BlocProvider.of<ProductBloc>(context);

    return AppScaffold(
      child: Column(
        children: [
          SearchInput(
            controller: searchController,
            onChanged: (val) {
              context.read<ProductBloc>().add(SearchProduct(keyword: val));
            },
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
                  onPressed: () => onCategoryTap(
                    0,
                    category: ProductCategory.none,
                  ),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/food.svg',
                  label: "Makanan",
                  isActive: _categoryIndex.value == 1,
                  onPressed: () => onCategoryTap(
                    1,
                    category: ProductCategory.food,
                  ),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/drink.svg',
                  label: "Minuman",
                  isActive: _categoryIndex.value == 2,
                  onPressed: () => onCategoryTap(
                    2,
                    category: ProductCategory.drink,
                  ),
                ),
                CategoryButton(
                  iconPath: 'assets/icons/snack.svg',
                  label: "Snack",
                  isActive: _categoryIndex.value == 3,
                  onPressed: () => onCategoryTap(
                    3,
                    category: ProductCategory.snack,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(12.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProductError) {
                // AppDialog.show(
                //   context,
                //   iconPath: 'assets/icons/error.svg',
                //   errorMessage: state.message,
                // );
                print('error ${state.message}');
              } else if (state is ProductSuccess) {
                var products = state.products;
                if (products.isEmpty) {
                  return const Expanded(child: ProductEmpty());
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: products[index],
                      ),
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
