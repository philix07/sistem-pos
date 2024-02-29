import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/blocs/checkout/checkout_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/formatter.dart';

import 'package:kerja_praktek/models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    int price = order.product.price * order.quantity;
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height / 8,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.primary,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.disabled,
            radius: 25.0,
            backgroundImage: NetworkImage(order.product.image),
          ),
          const SpaceWidth(15.0),

          //Column That Handle Item Name And Buttons
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                Text(
                  order.product.name,
                  maxLines: 2,
                  style: AppTextStyle.black(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Container()),
                const SpaceHeight(5.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<CheckOutBloc>()
                            .add(RemoveCheckOut(product: order.product));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      order.quantity.toString(),
                      style: AppTextStyle.black(fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<CheckOutBloc>()
                            .add(AddCheckOut(product: order.product));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SpaceWidth(5.0),

          // Column That Handle Price And Cancel Button
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Rp ${AppFormatter.number(price)}",
                    maxLines: 1,
                    style: AppTextStyle.black(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<CheckOutBloc>()
                          .add(DeleteCheckOut(product: order.product));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/cancel.svg',
                      height: 20,
                      width: 20,
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
