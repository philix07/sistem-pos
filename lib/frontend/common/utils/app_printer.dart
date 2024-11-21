import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/print.dart';

class AppPrinter {
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  void print(OrderModel order) async {
    printer.isConnected.then((isConnected) {
      if (isConnected == true) {
        //* Bill's Header
        printer.printNewLine();

        printer.printCustom(
          'Empek-Empek Nurali',
          PrintSize.mediumBold.val,
          PrintAlign.center.val,
        );

        //* Bill's Date
        var date = AppFormatter.dmy(order.createdAt);
        var time = AppFormatter.time(order.createdAt);
        printer.printNewLine();
        printer.printLeftRight(
          date,
          time,
          PrintSize.normal.val,
          format: "%-30s %30s",
        );
        printer.printNewLine();

        //* Bill's Cashier Info
        printer.printLeftRight(
          "Cashier",
          order.cashierName,
          PrintSize.normal.val,
          format: "%-30s %30s",
        );
        printer.printNewLine();
        printer.printCustom(
          getDivider(),
          PrintSize.normal.val,
          PrintAlign.center.val,
        );

        //* Order Detail Section
        for (var i = 0; i < order.orders.length; i++) {
          var orderItem = order.orders[i];

          //* Product Name
          printer.printCustom(
            orderItem.product.name,
            PrintSize.mediumBold.val,
            PrintAlign.left.val,
          );

          //* Product Quantity, Price, Subtotal Price
          var price = orderItem.product.price;
          var totalPrice = orderItem.quantity * orderItem.product.price;
          printer.printLeftRight(
            "${orderItem.quantity}   @   ${AppFormatter.number(price)}",
            (AppFormatter.number(totalPrice)).toString(),
            PrintSize.normal.val,
            format: "%-25s %30s",
          );

          if (i != order.orders.length - 1) printer.printNewLine();
        }

        //* Bill's Total Price Section
        printer.printNewLine();
        printer.printCustom(
          getDivider(),
          PrintSize.normal.val,
          PrintAlign.center.val,
        );

        printer.printLeftRight(
          'Payment Method',
          order.paymentMethod.value,
          PrintSize.normal.val,
          format: "%-30s %30s",
        );
        printer.printNewLine();

        printer.printLeftRight(
          'Total',
          AppFormatter.number(order.totalPrice),
          PrintSize.normal.val,
          format: "%-30s %30s",
        );

        printer.printNewLine();
        printer.printNewLine();
        printer.printNewLine();
        printer.printNewLine();
      }
    });
  }

  String getDivider() {
    return '----------------------------------------------------------------';
  }
}
