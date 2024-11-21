import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/order_repository.dart';
import 'package:kerja_praktek/models/order.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final _orderRepository = OrderRepository();

  //* to store item data for report purpose (1 item 1 OrderItem)
  List<OrderItem> orders = [];

  ReportBloc() : super(ReportInitial()) {
    on<ReportFetchMonthlyOrder>((event, emit) async {
      emit(ReportLoading());

      var year = event.year;
      var month = event.month;

      var result = await _orderRepository.fetchMonthlyOrder(year, month);
      result.fold((error) {
        emit(ReportError(message: error));
      }, (data) {
        orders = _updateLocalList(data);
        data.isEmpty
            ? emit(ReportEmpty())
            : emit(ReportSuccess(orders: orders));
      });
    });

    on<ReportFetchYearlyOrder>((event, emit) async {
      emit(ReportLoading());

      var year = event.year;
      DateTime startDate = DateTime(year, 1, 1);
      DateTime endDate = DateTime(year + 1, 1, 0);

      var result = await _orderRepository.fetchCustomOrder(startDate, endDate);
      result.fold((error) {
        emit(ReportError(message: error));
      }, (data) {
        orders = _updateLocalList(data);
        data.isEmpty
            ? emit(ReportEmpty())
            : emit(ReportSuccess(orders: orders));
      });
    });

    on<ReportFetchCustomOrder>((event, emit) async {
      emit(ReportLoading());

      DateTime startDate = event.startDate;
      DateTime endDate = event.endDate;

      var result = await _orderRepository.fetchCustomOrder(startDate, endDate);
      result.fold((error) {
        emit(ReportError(message: error));
      }, (data) {
        orders = _updateLocalList(data);
        data.isEmpty
            ? emit(ReportEmpty())
            : emit(ReportSuccess(orders: orders));
      });
    });

    on<ReportClearOrderList>((event, emit) async {
      emit(ReportEmpty());
      orders = _updateLocalList([]);
    });
  }

  List<OrderItem> _updateLocalList(List<OrderModel> orderList) {
    List<OrderItem> items = [];

    if (orderList.isEmpty) return items;

    orderList.forEach(((order) {
      order.orders.forEach(((item) {
        bool isNew = true;

        //* check if it's new item on the cart or not
        items.forEach(((localItem) {
          if (localItem.product.id == item.product.id) {
            isNew = false;
            localItem.quantity += item.quantity;
          }
        }));

        //* if it's new then we initialize new value
        if (isNew) {
          items.add(item);
        }
      }));
    }));

    return items;
  }
}
