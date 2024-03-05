import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/models/order.dart';

//* Display details of product bought and its quantity
class OrderProductList extends StatelessWidget {
  const OrderProductList({super.key, required this.orders});

  final List<OrderItem> orders;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 50 * orders.length),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 1.0),
          height: MediaQuery.of(context).size.height / 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    orders[index].product.name,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: AppTextStyle.black(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${orders[index].quantity}",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: AppTextStyle.black(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "*",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.black(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${orders[index].product.price}",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: AppTextStyle.black(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
