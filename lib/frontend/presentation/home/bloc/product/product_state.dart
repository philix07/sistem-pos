part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess({required this.products});
}

final class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

}
