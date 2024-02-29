part of 'checkout_bloc.dart';

sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutSuccess extends CheckOutState {
  final List<OrderItem> orders;
  final int totalPrice;

  CheckOutSuccess({
    required this.orders,
    required this.totalPrice,
  });
}

final class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError({required this.message});
}

final class CheckOutLoading extends CheckOutState {}
