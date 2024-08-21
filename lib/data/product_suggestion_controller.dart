import '../entity/product_suggestion_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class ProductSuggestionController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.productSuggestions;

  Future<bool> addProductSuggestion(ProductSuggestion productSuggestion) async {
    try {
      String id = productSuggestion.id;
      if (id.isEmpty) {
        id = await _firebase.registerData(
          data: productSuggestion,
          collection: _collection,
        );
        await _firebase.updateData(
          data: productSuggestion.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: productSuggestion,
          id: id,
          collection: _collection,
        );
      }
      return true;
    } catch (e, stackTrace) {
      return Future.error("Error while adding product suggestion: ${e.toString()}", stackTrace);
    }
  }

  Future<void> deleteProductSuggestion(String productSuggestionId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: productSuggestionId,
      );
    } catch (e) {
      print("Error while deleting product suggestion: ${e.toString()}");
    }
  }

  Future<void> updateProductSuggestion(ProductSuggestion productSuggestion) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: productSuggestion.id,
        data: productSuggestion,
      );
    } catch (e, stackTrace) {
      return Future.error("Error while updating product suggestion: ${e.toString()}", stackTrace);
    }
  }

  Future<ProductSuggestion> searchProductSuggestion(String productSuggestionId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: productSuggestionId,
      );
      return ProductSuggestion.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error("Error searching for product suggestion: ${e.toString()}", stackTrace);
    }
  }

  Future<List<ProductSuggestion>> searchAllProductSuggestions() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<ProductSuggestion> productSuggestions = [];
      for (var i in data) {
        productSuggestions.add(ProductSuggestion.fromJson(i));
      }
      return productSuggestions;
    } catch (e, stackTrace) {
      return Future.error("Error searching for product suggestions: ${e.toString()}", stackTrace);
    }
  }
}
