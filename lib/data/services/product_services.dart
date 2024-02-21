import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductService {
  // RemoteService is a class that is used for interacting with
  // external application, for example "Firebase"
  var firestore = FirebaseFirestore.instance;
  late CollectionReference productRef = firestore.collection('product');

  void fetchAll() {}

  void fetchByCategory(String category) {}

  Future<void> addProduct(Product product) async {
    await productRef.add(product.toMap());
  }

  void deleteProduct() {}

  void updateProduct() {}
}
