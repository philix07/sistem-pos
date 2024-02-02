import 'package:kerja_praktek/frontend/common/utils/formatter.dart';
import 'package:kerja_praktek/frontend/presentation/home/models/product_category.dart';

class ProductModel {
  final String image;
  final String name;
  final ProductCategory category;
  final int price;
  final int stock;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });

  String get priceFormat => AppFormatter.number(price);
}