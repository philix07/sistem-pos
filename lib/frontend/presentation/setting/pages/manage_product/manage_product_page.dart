import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';

import 'package:kerja_praktek/frontend/common/style/app_colors.dart';

import 'package:kerja_praktek/frontend/presentation/setting/pages/manage_product/add_product_page.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/edit_product_card.dart';
import 'package:kerja_praktek/frontend/blocs/product/product_bloc.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: true,
      appBarTitle: 'Manage Product',
      //* FAB to navigate into AddProduct page
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.background,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add_rounded,
          size: 40,
          color: AppColor.primary,
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        height: 60,
        child: Container(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(10.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductError) {
                Future.delayed(
                  const Duration(seconds: 1),
                  () => AppDialog.show(
                    context,
                    iconPath: 'assets/icons/error.svg',
                    message: state.message,
                  ),
                );
              } else if (state is ProductLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProductSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return EditProductCard(
                        product: state.products[index],
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
