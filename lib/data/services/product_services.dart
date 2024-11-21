import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:kerja_praktek/models/product.dart';

class ProductService {
  // RemoteService is a class that is used for interacting with
  // external application, for example "Firebase"

  final _productRef = FirebaseFirestore.instance.collection('product');
  final _storage = FirebaseStorage.instance;

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
      return const Left("Error Fetching Product");
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
      // Settle the imagePath
      String imagePath = await uploadImage(product.image);
      Product finalProduct = Product(
        id: product.id,
        image: imagePath,
        name: product.name,
        category: product.category,
        price: product.price,
        isAvailable: product.isAvailable,
        isBestSeller: product.isBestSeller,
      );

      // Upload the data into Cloud Firestore
      await _productRef.doc(product.id).set(finalProduct.toMap());
      // await _productRef.add(finalProduct.toMap());
      return "Successfully Added Product";
    } catch (e) {
      return "Failed To Add Product";
    }
  }

  Future<Either<String, Product>> updateProduct(
    Product product,
    bool isNewImage,
  ) async {
    try {
      String imagePath = product.image;
      if (isNewImage == true) {
        // Delete the previous image from Firebase Storage
        _storage.ref().child('products/${product.image}').delete();

        // Settle the imagePath
        imagePath = await uploadImage(product.image);
      }

      Product finalProduct = Product(
        id: product.id,
        image: imagePath,
        name: product.name,
        category: product.category,
        price: product.price,
        isAvailable: product.isAvailable,
        isBestSeller: product.isBestSeller,
      );

      await _productRef.doc(product.id).update(finalProduct.toMap());
      return Right(finalProduct);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> uploadImage(String imagePath) async {
    try {
      // Get a reference to the storage bucket
      Reference ref = _storage.ref().child('products/$imagePath');

      // Upload the file to Firebase Storage
      await ref.putFile(File(imagePath));

      // Get the download URL of the uploaded file
      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw e.toString();
    }
  }
}
