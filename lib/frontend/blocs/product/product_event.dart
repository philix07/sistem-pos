part of 'product_bloc.dart';

sealed class ProductEvent {}

final class FetchAll extends ProductEvent {}

final class FetchByCategory extends ProductEvent {
  final ProductCategory category;

  FetchByCategory({required this.category});
}

final class SearchProduct extends ProductEvent {
  final ProductCategory category;
  final String keyword;

  SearchProduct({required this.keyword, required this.category});
}

final class AddProduct extends ProductEvent {
  final Product product;

  AddProduct({required this.product});
}

final class ProductUpdate extends ProductEvent {
  final Product product;
  final bool isNewImage;

  ProductUpdate({required this.product, required this.isNewImage});
}

final class ProductDelete extends ProductEvent {
  final Product product;

  ProductDelete({required this.product});
}
