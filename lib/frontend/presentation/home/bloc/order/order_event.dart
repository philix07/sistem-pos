part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderStarted extends OrderEvent {}

final class AddOrder extends OrderEvent {
  final Product product;

  AddOrder({required this.product});
}

final class ReduceOrder extends OrderEvent {
  final Product product;

  ReduceOrder({required this.product});
}

final class DeleteOrder extends OrderEvent {
  final Product product;

  DeleteOrder({required this.product});
}
