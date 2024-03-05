part of 'history_bloc.dart';

sealed class HistoryEvent {}

// Fetch History Only Fetches This Month's History
class HistoryFetch extends HistoryEvent {}

class HistoryDelete extends HistoryEvent {
  final String id;
  final String deletionReason;

  HistoryDelete({
    required this.id,
    required this.deletionReason,
  });
}
