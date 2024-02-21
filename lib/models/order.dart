// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kerja_praktek/models/product.dart';

class Order {
  final String id;
  final String paymentMethod;
  final List<OrderItem> orders;
  final DateTime createdAt;
  final int totalPrice;

  Order({
    required this.id,
    required this.paymentMethod,
    required this.orders,
    required this.createdAt,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paymentMethod': paymentMethod,
      'orders': orders.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      paymentMethod: map['paymentMethod'] as String,
      orders: List<OrderItem>.from(
        (map['orders'] as List<int>).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdAt: map['createdAt'] as DateTime,
      totalPrice: map['totalPrice'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderItem {
  final Product product;
  final int quantity;

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
