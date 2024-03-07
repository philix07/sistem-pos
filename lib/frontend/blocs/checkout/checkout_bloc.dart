import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  List<OrderItem> orders = [];
  int totalPrice = 0;

  CheckOutBloc() : super(CheckOutSuccess(orders: [], totalPrice: 0)) {
    on<CheckOutStarted>((event, emit) {
      emit(CheckOutSuccess(orders: [], totalPrice: 0));
    });

    on<AddCheckOut>((event, emit) {
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

      emit(CheckOutSuccess(orders: orders, totalPrice: totalPrice));
    });

    on<RemoveCheckOut>((event, emit) {
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

      emit(CheckOutSuccess(orders: orders, totalPrice: totalPrice));
    });

    on<DeleteCheckOut>((event, emit) {
      // Handle The Total Price
      var deletedOrder =
          orders.firstWhere((order) => order.product.id == event.product.id);
      totalPrice -= deletedOrder.product.price * deletedOrder.quantity;

      orders.removeWhere((order) => order == deletedOrder);

      emit(CheckOutSuccess(orders: orders, totalPrice: totalPrice));
    });

    on<ClearCheckOut>((event, emit) {
      // Clear the order cart
      orders = <OrderItem>[];
      totalPrice = 0;
      emit(CheckOutSuccess(orders: orders, totalPrice: 0));
    });
  }
}
