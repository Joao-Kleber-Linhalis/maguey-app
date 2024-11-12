import 'package:flutter/material.dart';

import '../entity/mezcal_product.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class MezcalProductController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.productsCollection;

  Future<bool> addProduct(Product product) async {
    try {
      String id = product.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: product,
          collection: _collection,
        );
        await _firebase.updateData(
          data: product.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: product,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while signing up user ${e.toString()}{", stackTrace);
    }
  }

  Future<void> deleteMezcalProduct(String productId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: productId,
      );
    } catch (e) {
      debugPrint("Error while deleting mezcal product: ${e.toString()}");
    }
  }

  Future<void> updateMezcalProduct(Product product) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: product.id,
        data: product,
      );
    } catch (e, stackTrace) {
      return Future.error(
          "Error while updating mezcal product: ${e.toString()}", stackTrace);
    }
  }

  Future<Product> searchMezcalProduct(String productId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: productId,
      );
      return Product.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for mezcal product: ${e.toString()}", stackTrace);
    }
  }

  Future<List<Product>> searchMezcalProductsWithCondition(
      String condition, String fieldName) async {
    List<Product> products = [];
    try {
      final data = await _firebase.searchDataWithCondition(
        collection: _collection,
        cond: condition,
        condName: fieldName,
      );
      for (var element in data) {
        products.add(Product.fromJson(element));
      }
      return products;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while searching mezcal products with condition: ${e.toString()}",
          stackTrace);
    }
  }

  Future<List<Product>> searchAllProducts() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<Product> products = [];
      for (var i in data) {
        products.add(Product.fromJson(i));
      }
      return products;
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for brand: ${e.toString()}", stackTrace);
    }
  }
}
