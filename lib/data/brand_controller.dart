import 'package:flutter/material.dart';

import '../entity/brand_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class BrandController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.brandsCollection;

  Future<bool> addBrand(Brand brand) async {
    try {
      String id = brand.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: brand,
          collection: _collection,
        );
        await _firebase.updateData(
          data: brand.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: brand,
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

  Future<void> deleteBrand(String brandId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: brandId,
      );
    } catch (e) {
      debugPrint("Error while deleting brand: ${e.toString()}");
    }
  }

  Future<void> updateBrand(Brand brand) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: brand.id,
        data: brand,
      );
    } catch (e, stackTrace) {
      return Future.error(
          "Error while updating brand: ${e.toString()}", stackTrace);
    }
  }

  Future<Brand> searchBrand(String brandId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: brandId,
      );
      return Brand.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for brand: ${e.toString()}", stackTrace);
    }
  }

  Future<List<Brand>> searchAllBrand() async {
    try {
      final data = await _firebase.searchAllData(
        collection: _collection,
      );
      List<Brand> brands = [];
      for (var i in data) {
        brands.add(Brand.fromJson(i));
      }
      return brands;
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for brand: ${e.toString()}", stackTrace);
    }
  }
}
