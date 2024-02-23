import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kerja_praktek/models/product.dart';
import 'package:dartz/dartz.dart';

class ProductService {
  // RemoteService is a class that is used for interacting with
  // external application, for example "Firebase"
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _productRef = _firestore.collection('product');

  Future<Either<String, List<Product>>> fetchAll() async {
    try {
      List<Product> products = [];

      var result = await _productRef.get();
      result.docs.forEach(((val) {
        var data = val.data() as Map<String, dynamic>;
        products.add(Product.fromMap(data));
      }));

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> deleteProduct(String id) async {
    try {
      await _productRef.doc(id).delete();
      return "Successfully Deleted Product";
    } catch (e) {
      return "Failed To Delete Product";
    }
  }

  Future<String> addProduct(Product product) async {
    try {
      await _productRef.add(product.toMap());
      return "Successfully Added Product";
    } catch (e) {
      return "Failed To Add Product";
    }
  }

  void updateProduct() async {}
}
