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

  Future<Either<String, List<OrderModel>>> fetchMonthlyOrder(
    int year,
    int month,
  ) async {
    var result = await _orderService.fetchMonthlyOrder(year, month);

    bool isError = false;
    String message = "";
    List<OrderModel> orders = [];

    result.fold((error) {
      isError = true;
      message = error;
    }, (data) {
      orders = data;
    });

    if (isError) {
      return Left(message);
    }
    return Right(orders);
  }

  Future<Either<String, String>> deleteOrder(
      String orderId, String deletionReason) async {
    var result = await _orderService.deleteOrder(orderId, deletionReason);

    bool isError = false;
    String message = "";

    result.fold((error) {
      isError = true;
      message = error;
    }, (success) {
      message = success;
    });

    if (isError) {
      return Left(message);
    }
    return Right(message);
  }
}
