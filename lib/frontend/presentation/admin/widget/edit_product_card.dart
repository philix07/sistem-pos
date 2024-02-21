import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/admin/edit_product_page.dart';
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
      height: MediaQuery.of(context).size.height / 8,
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
            child: SvgPicture.asset(
              'assets/icons/food.svg',
              width: 20,
              height: 20,
            ),
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
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductPageDetail(
                            product: product,
                          ),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/repair-tool.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
