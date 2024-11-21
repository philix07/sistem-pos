import 'package:kerja_praktek/models/order.dart';

class ReportModel {
  final int foodsSold;
  final int drinksSold;
  final int snacksSold;
  final int totalRevenue;
  final List<OrderItem> items;

  ReportModel({
    required this.foodsSold,
    required this.drinksSold,
    required this.snacksSold,
    required this.totalRevenue,
    required this.items,
  });
}
