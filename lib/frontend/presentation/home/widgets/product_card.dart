import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/models/product.dart';

import '../../../blocs/checkout/checkout_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height / 3.3,
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
                child: InkWell(
                  onTap: () {
                    //TODO: Display Product Image Preview
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColor.disabled,
                    radius: 55.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(product.image),
                      radius: 52.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    product.name,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.black(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Text(
                product.category.value,
                style: AppTextStyle.gray(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0,
                ),
              ),
              const SpaceHeight(7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      //TODO: Remove Item To Cart
                      context
                          .read<CheckOutBloc>()
                          .add(RemoveCheckOut(product: product));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        color: AppColor.primary,
                      ),
                      child: const Icon(
                        Icons.remove_outlined,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Rp ${product.priceFormat}",
                      style: AppTextStyle.black(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //TODO: Add Item To Cart
                      context
                          .read<CheckOutBloc>()
                          .add(AddCheckOut(product: product));
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
        BlocBuilder<CheckOutBloc, CheckOutState>(
          builder: (context, state) {
            if (state is CheckOutError) {
              //TODO: Handle Order Error
            } else if (state is CheckOutSuccess) {
              //Check For The Product Data
              for (var order in state.orders) {
                if (order.product.id == product.id) {
                  return Container(
                    alignment: Alignment.topRight,
                    width: double.maxFinite,
                    margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                    child: CircleAvatar(
                      backgroundColor: AppColor.primary,
                      radius: 15,
                      child: Text(
                        order.quantity.toString(),
                        style: AppTextStyle.white(),
                      ),
                    ),
                  );
                }
              }
            }

            //If The State Is Not Recognized
            return const SizedBox();
          },
        )
      ],
    );
  }
}
