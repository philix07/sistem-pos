import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:dartz/dartz.dart';

class OrderService {
  final _orderRef = FirebaseFirestore.instance.collection('orders');

  Future<Either<String, OrderModel>> addOrder(OrderModel orderModel) async {
    try {
      await _orderRef.doc(orderModel.id).set(orderModel.toMap());
      return Right(orderModel);
    } catch (e) {
      print(e);
      return const Left("Failed To Create Order");
    }
  }

  Future<Either<String, List<OrderModel>>> fetchMonthlyOrder(
    int year,
    int month,
  ) async {
    try {
      var orders = <OrderModel>[];

      DateTime firstDayOfMonth = DateTime(year, month, 1);
      DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

      var result = await _orderRef
          .where('createdAt', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('createdAt', isLessThanOrEqualTo: lastDayOfMonth)
          .get();

      for (var doc in result.docs) {
        var data = doc.data();
        orders.add(OrderModel.fromMap(data));
      }

      return Right(orders);
    } catch (e) {
      print(e);
      return const Left('Failed To Fetch Monthly Order');
    }
  }

  Future<Either<String, String>> deleteOrder(
    String id,
    String deletionReason,
  ) async {
    try {
      await _orderRef.doc(id).update({
        'isDeleted': true,
        'deletionReason': deletionReason,
        'deletedAt': DateTime.now(),
      });

      return const Right('Order Successfully Deleted');
    } catch (e) {
      return const Left('Failed To Delete Order');
    }
  }
}
