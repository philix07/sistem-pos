part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderStarted extends OrderEvent {}

final class AddOrder extends OrderEvent {
  final Product product;

  AddOrder({required this.product});
}

final class RemoveOrder extends OrderEvent {
  final Product product;

  RemoveOrder({required this.product});
}
