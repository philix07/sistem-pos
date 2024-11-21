// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';

class Product {
  final String id;
  final String image;
  final String name;
  final int price;
  final bool isAvailable;
  final bool isBestSeller;
  final ProductCategory category;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.isAvailable,
    required this.isBestSeller,
  });

  String get priceFormat => AppFormatter.number(price);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'category': category.value,
      'price': price,
      'isAvailable': isAvailable,
      'isBestSeller' : isBestSeller,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      category: ProductCategory.fromString(map['category']),
      price: map['price'] as int,
      isAvailable: map['isAvailable'] as bool,
      isBestSeller: map['isBestSeller'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ProductCategory {
  none('None'),
  drink('Minuman'),
  food('Makanan'),
  snack('Snack');

  final String value;
  const ProductCategory(this.value);

  static ProductCategory fromString(String categoryString) {
    switch (categoryString) {
      case 'Makanan':
        return ProductCategory.food;
      case 'Minuman':
        return ProductCategory.drink;
      case 'Snack':
        return ProductCategory.snack;
      // Add more cases for other categories
      default:
        return ProductCategory.none;
    }
  }
}
