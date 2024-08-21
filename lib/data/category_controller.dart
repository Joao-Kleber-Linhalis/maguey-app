import '../entity/category_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class CategoryController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.categoriesCollection;

  Future<bool> addCategory(Category category) async {
    try {
      String id = category.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: category,
          collection: _collection,
        );
        await _firebase.updateData(
          data: category.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: category,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error("Error while signing up user ${e.toString()}{", stackTrace);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: categoryId,
      );
    } catch (e) {
      print("Error while deleting category: ${e.toString()}");
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: category.id,
        data: category,
      );
    } catch (e, stackTrace) {
      return Future.error("Error while updating category: ${e.toString()}", stackTrace);
    }
  }

  Future<Category> searchCategory(String categoryId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: categoryId,
      );
      return Category.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error("Error searching for category: ${e.toString()}", stackTrace);
    }
  }

  Future<List<Category>> searchAllCategories() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<Category> categories = [];
      for (var i in data) {
        categories.add(Category.fromJson(i));
      }
      return categories;
    } catch (e, stackTrace) {
      return Future.error("Error searching for brand: ${e.toString()}", stackTrace);
    }
  }
}
