import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/formatter.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/order_product_list.dart';
import 'package:kerja_praktek/models/order.dart';

class RemovedHistoryCard extends StatelessWidget {
  const RemovedHistoryCard({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var mainTextStyle = AppTextStyle.blue(
      fontSize: 10.0,
      fontWeight: FontWeight.w700,
    );

    var subTextStyle = AppTextStyle.black(
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 6.0,
            blurStyle: BlurStyle.outer,
            color: AppColor.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //* Deletion Date
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "DELETED AT",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppFormatter.dateTime(orderModel.createdAt),
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(3.0),

          //* Name
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "NAMA KASIR",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              orderModel.cashierName,
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(3.0),

          //* Payment Method
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "METODE PEMBAYARAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              orderModel.paymentMethod.value,
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(3.0),

          //* Total Payment
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "TOTAL TAGIHAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Rp ${AppFormatter.number(orderModel.totalPrice)}",
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(3.0),

          //* Products
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "PRODUCTS",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          Flexible(child: OrderProductList(orders: orderModel.orders)),
          const SpaceHeight(5.0),

          //* Deletion Reason
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "ALASAN PENGHAPUSAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          Text(
            orderModel.deletionReason,
            style: subTextStyle,
          ),
          const SpaceHeight(3.0),
        ],
      ),
    );
  }
}
