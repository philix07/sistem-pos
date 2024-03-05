// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kerja_praktek/models/product.dart';

class OrderModel {
  final String id;
  final String cashierId;
  final String cashierName;
  final PaymentMethod paymentMethod;
  final List<OrderItem> orders;
  final DateTime createdAt;
  final int totalPrice;
  bool isDeleted;
  String deletionReason;
  DateTime? deletedAt;

  OrderModel({
    required this.id,
    required this.cashierId,
    required this.cashierName,
    required this.paymentMethod,
    required this.orders,
    required this.createdAt,
    required this.totalPrice,
    this.isDeleted = false,
    this.deletionReason = '',
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cashierId': cashierId,
      'cashierName': cashierName,
      'paymentMethod': paymentMethod.value,
      'orders': orders.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'totalPrice': totalPrice,
      'isDeleted': isDeleted,
      'deletionReason': deletionReason,
      'deletedAt': deletedAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    //* Convert List Of Order
    var orders = <OrderItem>[];
    var rawOrders = map['orders'] as List;
    rawOrders.forEach(((order) {
      orders.add(OrderItem.fromMap(order));
    }));

    //* Convert Timestamp to DateTime (Firebase only stores Timestamp)
    var createdTimestamp = map['createdAt'] as Timestamp;
    var createdAt = createdTimestamp.toDate();

    //* Check if there is deletedAt property
    DateTime? deletedAt;
    if (map['deletedAt'] != null) {
      var deletedTimestamp = map['deletedAt'] as Timestamp;
      deletedAt = deletedTimestamp.toDate();
    }

    return OrderModel(
      id: map['id'] as String,
      cashierId: map['cashierId'] as String,
      cashierName: map['cashierName'] as String,
      paymentMethod: PaymentMethod.fromString(map['paymentMethod'] as String),
      orders: orders,
      createdAt: createdAt,
      totalPrice: map['totalPrice'] as int,
      isDeleted: map['isDeleted'] as bool,
      deletionReason: map['deletionReason'] as String,
      deletedAt: deletedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderItem {
  final Product product;
  int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum PaymentMethod {
  none('None'),
  cash('Cash'),
  transfer('Transfer');

  final String value;

  const PaymentMethod(this.value);

  static PaymentMethod fromString(String paymentMethod) {
    switch (paymentMethod) {
      case 'Cash':
        return PaymentMethod.cash;
      case 'Transfer':
        return PaymentMethod.transfer;
      // Add more cases for other categories
      default:
        return PaymentMethod.none;
    }
  }
}
