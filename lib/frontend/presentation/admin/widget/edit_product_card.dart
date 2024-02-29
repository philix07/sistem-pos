import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/admin/edit_product_page.dart';
import 'package:kerja_praktek/frontend/blocs/product/product_bloc.dart';
import 'package:kerja_praktek/models/product.dart';

class EditProductCard extends StatelessWidget {
  const EditProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      height: MediaQuery.of(context).size.height / 9,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: AppColor.primary,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.disabled,
            radius: 25.0,
            backgroundImage: NetworkImage(product.image),
          ),
          const SpaceWidth(15.0),

          //Column That Handle Item Name And Buttons
          Expanded(
            flex: 2,
            child: Text(
              product.name,
              style: AppTextStyle.black(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Column That Handle Price And Cancel Button
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rp ${product.priceFormat}",
                  style: AppTextStyle.black(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductPageDetail(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/repair-tool.svg',
                        colorFilter: const ColorFilter.mode(
                          AppColor.blue,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Delete Product From Database
                        AppDialog.showConfirmationDialog(
                          context,
                          iconPath: 'assets/icons/error.svg',
                          message:
                              'Are you sure you want to delete this product?',
                          onConfirmation: () {
                            context
                                .read<ProductBloc>()
                                .add(ProductDelete(product: product));

                            Navigator.pop(context);
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/cancel.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.redAccent,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
