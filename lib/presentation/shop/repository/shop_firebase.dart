import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';

class ShopFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ShopModel>> getShopsFromFirebase() async {
    var data =
        await _firestore.collection(CollectionNames.shopCollection).get();

    List<ShopModel> shops =
        data.docs.map((e) => ShopModel.fromJson(e.data(), e.id)).toList();
    return shops;
  }

  Future<List<ShopModel>> getSearchedShops({
    required String query,
  }) async {
    var data =
        await _firestore.collection(CollectionNames.shopCollection).get();

    List<ShopModel> products = data.docs
        .map((prod) => ShopModel.fromJson(prod.data(), prod.id))
        .where((prod) => prod.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return products;
  }

  Future<ShopModel> getSelectedShop({
    required String id,
  }) async {
    // Getting the base product info
    var doc = await _firestore
        .collection(CollectionNames.shopCollection)
        .doc(id)
        .get();

    ShopModel shop = ShopModel.fromJson(doc.data()!, id);
    return shop;
  }
}
