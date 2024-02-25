import 'package:bloc/bloc.dart';
import 'package:kerja_praktek/data/repository/product_repository.dart';
import 'package:kerja_praktek/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository = ProductRepository();
  List<Product> products = [];

  ProductBloc() : super(ProductSuccess(products: [])) {
    on<FetchAll>((event, emit) async {
      emit(ProductLoading());

      var result = await repository.fetchAll();
      result.fold((error) {
        emit(ProductError(message: error));
      }, (data) {
        products = data;
        emit(ProductSuccess(products: data));
      });
    });

    on<FetchByCategory>((event, emit) {
      emit(ProductLoading());

      if (event.category == ProductCategory.none) {
        emit(ProductSuccess(products: products));
      } else {
        List<Product> filteredProduct = [];

        products.forEach(((e) {
          e.category == event.category ? filteredProduct.add(e) : null;
        }));

        emit(ProductSuccess(products: filteredProduct));
      }
    });

    on<SearchProduct>((event, emit) {
      emit(ProductLoading());
      var keyword = event.keyword.toLowerCase();

      if (keyword == "") {
        emit(ProductSuccess(products: products));
      } else {
        List<Product> filteredProduct = products
            .where((val) => val.name.toLowerCase().startsWith(keyword))
            .toList();

        emit(ProductSuccess(products: filteredProduct));
      }
    });

    on<AddProduct>((event, emit) async {
      emit(ProductLoading());

      await repository.addProduct(event.product);
    });
  }
}
