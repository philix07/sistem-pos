import 'package:dartz/dartz.dart';
import 'package:kerja_praktek/data/services/product_services.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductRepository {
  //Repository is a class that's interacting between "Services" and "View Model"
  final _service = ProductService();

  Future<String> addProduct(Product product) async {
    return await _service.addProduct(product);
  }

  Future<Either<String, Product>> updateProduct(Product product, bool isNewImage) async {
    var result = await _service.updateProduct(product, isNewImage);

    bool isError = false;
    String message = "";
    Product productData = product;

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      productData = data;
    });

    if (isError == true) return Left(message);
    return Right(productData);
  }

  Future<String> deleteProduct(Product product) async {
    return await _service.deleteProduct(product.id);
  }

  Future<Either<String, List<Product>>> fetchAll() async {
    var result = await _service.fetchAll();

    bool isError = false;
    String message = "";
    List<Product> productData = [];

    result.fold((errorMessage) {
      isError = true;
      message = errorMessage;
    }, (data) {
      productData = data;
    });

    if (isError) return Left(message);
    return Right(productData);
  }
}
