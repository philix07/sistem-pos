part of 'product_bloc.dart';

sealed class ProductEvent {}

final class FetchAll extends ProductEvent {}

final class FetchByCategory extends ProductEvent {
  final ProductCategory category;

  FetchByCategory({required this.category});
}

final class SearchProduct extends ProductEvent {
  final String keyword;

  SearchProduct({required this.keyword});
}
