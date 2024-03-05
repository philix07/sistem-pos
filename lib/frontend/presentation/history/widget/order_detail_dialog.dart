import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/formatter.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/order_product_list.dart';
import 'package:kerja_praktek/models/order.dart';

class OrderDetailDialog extends StatelessWidget {
  const OrderDetailDialog({super.key, required this.orderModel});

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

    return AlertDialog(
      alignment: Alignment.center,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //* Name
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "NAMA KASIR",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          Flexible(
            child: Text(
              orderModel.cashierName,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(5.0),

          //* Payment Method
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "METODE PEMBAYARAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          Flexible(
            child: Text(
              orderModel.paymentMethod.value,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(5.0),

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
          const SpaceHeight(5.0),

          //* Transaction Date
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("WAKTU TRANSAKSI", maxLines: 1, style: mainTextStyle),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppFormatter.dateTime(orderModel.createdAt),
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
          const SpaceHeight(5.0),

          //* Products
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("PRODUCTS", maxLines: 1, style: mainTextStyle),
          ),
          //! This part here is still error fix THIS LATER!!!!
          Flexible(
            child: OrderProductList(
              orders: orderModel.orders,
            ),
          ),
        ],
      ),
    );
  }
}
