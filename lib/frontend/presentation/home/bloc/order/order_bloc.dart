import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<OrderItem> orders = [];

  OrderBloc() : super(OrderSuccess(orders: [])) {
    on<OrderStarted>((event, emit) {
      emit(OrderSuccess(orders: []));
    });

    on<AddOrder>((event, emit) {
      print("Add order accessed");
      
      bool isNew = true;
      orders.forEach(((order) {
        if (order.product.id == event.product.id) {
          isNew = false;
          order.quantity += 1;
        }
      }));

      if (isNew) {
        orders.add(OrderItem(product: event.product, quantity: 1));
      }

      var newOrders = [...orders];

      print("Is new : $isNew");
      print("Items inside order list");
      for (var order in newOrders) {
        print(order.product.name);
      }

      emit(OrderSuccess(orders: newOrders));
      print("Emit state accessed");
    });

    on<RemoveOrder>((event, emit) {
      emit(OrderSuccess(orders: []));
    });
  }
}
