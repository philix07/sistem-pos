// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

sealed class OrderEvent {}

class AddOrder extends OrderEvent {
  OrderModel order;

  AddOrder({required this.order});
}
