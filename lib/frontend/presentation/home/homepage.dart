import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/checkout/checkout_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/search_input.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/blocs/product/product_bloc.dart';
import 'package:kerja_praktek/models/product.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/category_button.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/product_card.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/data_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _categoryIndex = ValueNotifier(0);
  var _productCategory = ProductCategory.none;

  @override
  void initState() {
    context.read<CheckOutBloc>().add(CheckOutStarted());
    super.initState();
  }

  void onCategoryTap(int index, {required ProductCategory category}) {
    setState(() {
      _categoryIndex.value = index;
      _productCategory = category;
    });

    context.read<ProductBloc>().add(FetchByCategory(category: category));
  }

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return AppScaffold(
      child: Column(
        children: [
          SearchInput(
            controller: searchController,
            onChanged: (val) {
              context
                  .read<ProductBloc>()
                  .add(SearchProduct(keyword: val, category: _productCategory));
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
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProductError) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  AppDialog.show(
                    context,
                    iconPath: 'assets/icons/error.svg',
                    message: state.message,
                  );
                });
              } else if (state is ProductSuccess) {
                var products = state.products;
                if (products.isEmpty) {
                  return const Expanded(
                    child: DataEmpty(
                      title: "Produk Tidak Ditemukan",
                    ),
                  );
                } else {
                  List<Product> availableProduct = [];
                  List<Product> unAvailableProduct = [];
                  List<Product> sortedProducts = [];

                  products.forEach(((product) {
                    if (product.isAvailable) {
                      availableProduct.add(product);
                    } else {
                      unAvailableProduct.add(product);
                    }
                  }));

                  availableProduct.sort((a, b) {
                    var aValue = a.isBestSeller ? 1 : 0;
                    var bValue = b.isBestSeller ? 1 : 0;

                    return bValue.compareTo(aValue);
                  });

                  sortedProducts.addAll(availableProduct);
                  sortedProducts.addAll(unAvailableProduct);

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: sortedProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: sortedProducts[index],
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
