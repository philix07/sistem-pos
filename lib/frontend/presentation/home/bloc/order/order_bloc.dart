import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<OrderItem> orders = [];
  int totalPrice = 0;

  OrderBloc() : super(OrderSuccess(orders: [], totalPrice: 0)) {
    on<OrderStarted>((event, emit) {
      emit(OrderSuccess(orders: [], totalPrice: 0));
    });

    on<AddOrder>((event, emit) {
      bool isNew = true;
      orders.forEach(((order) {
        if (order.product.id == event.product.id) {
          isNew = false;
          totalPrice += event.product.price;
          order.quantity += 1;
        }
      }));

      if (isNew) {
        totalPrice += event.product.price;
        orders.add(OrderItem(product: event.product, quantity: 1));
      }

      emit(OrderSuccess(orders: orders, totalPrice: totalPrice));
    });

    on<ReduceOrder>((event, emit) {
      bool isDeleted = false;
      OrderItem? waitingForDelete;

      orders.forEach(((order) {
        if (order.product.id == event.product.id) {
          if (order.quantity != 0) {
            totalPrice -= event.product.price;
            order.quantity -= 1;
          }

          //We cannot immediately delete an item when it's iterating
          if (order.quantity == 0) {
            isDeleted = true;
            waitingForDelete = order;
          }
        }
      }));

      if (isDeleted) {
        orders.remove(waitingForDelete);
      }

      emit(OrderSuccess(orders: orders, totalPrice: totalPrice));
    });

    on<DeleteOrder>((event, emit) {
      // Handle The Total Price
      var deletedOrder =
          orders.firstWhere((order) => order.product.id == event.product.id);
      totalPrice -= deletedOrder.product.price * deletedOrder.quantity;

      orders.removeWhere((order) => order == deletedOrder);

      emit(OrderSuccess(orders: orders, totalPrice: totalPrice));
    });
  }
}
