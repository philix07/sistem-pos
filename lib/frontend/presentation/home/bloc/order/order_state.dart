part of 'order_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderSuccess extends OrderState {
  final List<OrderItem> orders;
  final int totalPrice;

  OrderSuccess({required this.orders, required this.totalPrice,});
}

final class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}

final class OrderLoading extends OrderState {}
