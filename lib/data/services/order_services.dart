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
}
