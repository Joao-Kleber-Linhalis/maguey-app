import '../entity/shops.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class ShopController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.shopsCollection;

  Future<bool> addShop(ShopEntity shop) async {
    try {
      String id = shop.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: shop,
          collection: _collection,
        );
        await _firebase.updateData(
          data: shop.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: shop,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error("Error while adding shop ${e.toString()}", stackTrace);
    }
  }

  Future<void> deleteShop(String shopId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: shopId,
      );
    } catch (e) {
      print("Error while deleting shop: ${e.toString()}");
    }
  }

  Future<void> updateShop(ShopEntity shop) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: shop.id,
        data: shop,
      );
    } catch (e, stackTrace) {
      return Future.error("Error while updating shop: ${e.toString()}", stackTrace);
    }
  }

  Future<ShopEntity> searchShop(String shopId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: shopId,
      );
      return ShopEntity.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error("Error searching for shop: ${e.toString()}", stackTrace);
    }
  }

  Future<List<ShopEntity>> searchAllShops() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<ShopEntity> shops = [];
      for (var i in data) {
        shops.add(ShopEntity.fromJson(i));
      }
      return shops;
    } catch (e, stackTrace) {
      return Future.error("Error searching for shops: ${e.toString()}", stackTrace);
    }
  }
}
