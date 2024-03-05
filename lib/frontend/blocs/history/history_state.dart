part of 'history_bloc.dart';

sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}

final class HistorySuccess extends HistoryState {
  final List<OrderModel> orders;

  HistorySuccess({required this.orders});
}

final class HistoryDeleted extends HistoryState {
  final String message;

  HistoryDeleted({required this.message});
}
