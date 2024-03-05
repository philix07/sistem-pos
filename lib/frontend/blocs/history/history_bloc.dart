import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/order_repository.dart';
import 'package:kerja_praktek/models/order.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final _orderRepository = OrderRepository();
  var _orders = <OrderModel>[];

  HistoryBloc() : super(HistoryInitial()) {
    on<HistoryFetch>((event, emit) async {
      emit(HistoryLoading());

      var year = DateTime.now().year;
      var month = DateTime.now().month;

      var result = await _orderRepository.fetchMonthlyOrder(year, month);
      result.fold((error) {
        emit(HistoryError(message: error));
      }, (data) {
        _orders = data;
        emit(HistorySuccess(orders: data));
      });
    });

    on<HistoryDelete>((event, emit) async {
      emit(HistoryLoading());

      var result = await _orderRepository.deleteOrder(
        event.id,
        event.deletionReason,
      );

      result.fold((error) {
        emit(HistoryError(message: error));
      }, (success) {
        //* Modify the local order data
        var modifiedOrder = _orders.firstWhere((order) => order.id == event.id);
        _orders.remove(modifiedOrder);

        modifiedOrder.isDeleted = true;
        modifiedOrder.deletionReason = event.deletionReason;
        _orders.add(modifiedOrder);

        emit(HistorySuccess(orders: _orders));
      });
    });
  }
}
