import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/order_repository.dart';
import 'package:kerja_praktek/models/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _orderRepository = OrderRepository();
  final _orders = <OrderModel>[];

  OrderBloc() : super(OrderSuccess(orders: <OrderModel>[])) {
    on<OrderAdd>((event, emit) async {
      emit(OrderLoading());
      print('add order accessed');
      var result = await _orderRepository.addOrder(event.order);

      result.fold((errorMessage) {
        emit(OrderError(message: errorMessage));
        print('error');
      }, (data) {
        _orders.add(data);
        emit(OrderSuccess(orders: _orders));
        print('success');
      });
    });
  }
}
