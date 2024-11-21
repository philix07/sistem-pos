// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'report_bloc.dart';

sealed class ReportEvent {}

class ReportFetchCustomOrder extends ReportEvent {
  DateTime startDate;
  DateTime endDate;

  ReportFetchCustomOrder({
    required this.startDate,
    required this.endDate,
  });
}

class ReportFetchMonthlyOrder extends ReportEvent {
  int month;
  int year;

  ReportFetchMonthlyOrder({
    required this.month,
    required this.year,
  });
}

class ReportFetchYearlyOrder extends ReportEvent {
  int year;

  ReportFetchYearlyOrder({
    required this.year,
  });
}

class ReportClearOrderList extends ReportEvent {}
