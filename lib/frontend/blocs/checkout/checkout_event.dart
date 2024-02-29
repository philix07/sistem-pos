part of 'checkout_bloc.dart';

sealed class CheckOutEvent {}

final class CheckOutStarted extends CheckOutEvent {}

final class AddCheckOut extends CheckOutEvent {
  final Product product;

  AddCheckOut({required this.product});
}

final class RemoveCheckOut extends CheckOutEvent {
  final Product product;

  RemoveCheckOut({required this.product});
}

final class DeleteCheckOut extends CheckOutEvent {
  final Product product;

  DeleteCheckOut({required this.product});
}

final class ClearCheckOut extends CheckOutEvent {}

final class CompleteOrder extends CheckOutEvent {}
