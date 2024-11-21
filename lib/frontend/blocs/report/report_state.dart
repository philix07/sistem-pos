part of 'report_bloc.dart';

sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportError extends ReportState {
  final String message;

  ReportError({required this.message});
}

final class ReportSuccess extends ReportState {
  final List<OrderItem> orders;

  ReportSuccess({required this.orders});
}

final class ReportEmpty extends ReportState{}
