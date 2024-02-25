import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/presentation/home/bloc/order/order_bloc.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    int qty = 1;

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
                child: CircleAvatar(
                  backgroundColor: AppColor.disabled,
                  radius: 55.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(product.image),
                    radius: 52.0,
                  ),
                ),
              ),
              Expanded(child: Container()),
              Text(
                product.name,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: AppTextStyle.black(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0,
                  overflow: TextOverflow.ellipsis,
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
                      context.read<OrderBloc>().add(AddOrder(product: product));
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
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderError) {
              //TODO: Handle Order Error
            } else if (state is OrderSuccess) {
              if (state.orders.isEmpty) {
                //TODO: Cart Is Empty
              } else {
                //Check For The Product Data
                state.orders.forEach(((order) {
                  print(order.product.name);
                  order.product.id == product.id
                      ? Container(
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
                        )
                      : const SizedBox();
                }));
              }
            }
            //if state is not detected
            return const SizedBox();
          },
        )
      ],
    );
  }
}
