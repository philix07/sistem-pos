part of 'order_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderSuccess({required this.orders});
}
