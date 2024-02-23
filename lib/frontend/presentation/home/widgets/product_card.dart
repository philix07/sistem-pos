import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.data,
    // required this.onButtonPressed,
  });

  final Product data;
  // final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.width / 1,
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            color: AppColor.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColor.card),
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: AppColor.disabled,
                  radius: 55.0,
                  child: SvgPicture.asset('assets/icons/food.svg'),
                ),
              ),
              const SpaceHeight(12.0),
              Text(
                data.name,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: AppTextStyle.black(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                data.category.value,
                style: AppTextStyle.gray(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0,
                ),
              ),
              const SpaceHeight(7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Rp ${data.priceFormat}",
                      style: AppTextStyle.black(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Bloc that handles order item
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        color: AppColor.primary,
                      ),
                      child: const Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
