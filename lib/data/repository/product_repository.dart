import 'package:dartz/dartz.dart';
import 'package:kerja_praktek/data/services/product_services.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductRepository {
  //Repository is a class that's interacting between "Services" and "View Model"
  ProductService service = ProductService();

  Future<Either<String, List<Product>>> fetchAll() async {
    var result = await service.fetchAll();
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
