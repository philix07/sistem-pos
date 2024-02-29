import 'package:dartz/dartz.dart';
import 'package:kerja_praktek/data/services/order_services.dart';
import 'package:kerja_praktek/models/order.dart';

class OrderRepository {
  final _orderService = OrderService();

  Future<Either<String, OrderModel>> addOrder(OrderModel orderModel) async {
    var result = await _orderService.addOrder(orderModel);

    bool isError = false;
    String message = "";
    OrderModel orderData = orderModel;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      orderData = data;
    });

    if (isError) {
      return Left(message);
    }
    return Right(orderData);
  }
}
