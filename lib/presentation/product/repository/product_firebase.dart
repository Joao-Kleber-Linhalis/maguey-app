import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';

class ProductFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProductsFromFirebase({
    required String categoryId,
    String? subCategoryId,
  }) async {
    var data =
        await _firestore.collection(CollectionNames.productsCollection).get();

    List<ProductModel> products = data.docs
        .map((e) => ProductModel.fromJson(e.data(), e.id))
        .where((prod) => subCategoryId != null && prod.subCategoryId != null
            ? prod.subCategoryId!.toLowerCase() == subCategoryId.toLowerCase()
            : prod.categoryId.toLowerCase() == categoryId.toLowerCase())
        .toList();
    return products;
  }

  Future<List<ProductModel>> getSearchedProducts({
    required String query,
  }) async {
    var data =
        await _firestore.collection(CollectionNames.productsCollection).get();

    List<ProductModel> products = data.docs
        .map((prod) => ProductModel.fromJson(prod.data(), prod.id))
        .where((prod) {
      return prod.name.toLowerCase().contains(query.toLowerCase()) ||
          prod.categoryName.toLowerCase().contains(query.toLowerCase()) ||
          (prod.subCategoryName == null
              ? false
              : prod.subCategoryName!
                  .toLowerCase()
                  .contains(query.toLowerCase()));
    }).toList();
    return products;
  }

  Future<ProductModel> getSelectedProduct({
    required String id,
  }) async {
    // Getting the base product info
    var doc = await _firestore
        .collection(CollectionNames.productsCollection)
        .doc(id)
        .get();
    Map<String, dynamic> productInfo = doc.data()!;

    // Getting the product reviews from the heirarchy (product -> reviews)
    var reviewDoc = await _firestore
        .collection(CollectionNames.productsCollection)
        .doc(id)
        .collection(CollectionNames.reviewCollection)
        .get();
    Map<String, dynamic> reviews = {"reviews": []};
    for (QueryDocumentSnapshot reviewSnapshot in reviewDoc.docs) {
      var review = reviewSnapshot.data() as Map<String, dynamic>;
      review.addEntries({"id": reviewSnapshot.id}.entries);
      reviews['reviews'].add(review);
    }

    // Getting all product flavors from the flavors screen
    var data =
        await _firestore.collection(CollectionNames.flavorCollection).get();

    List<FlavorModel> flavors = data.docs
        .map((flavor) => FlavorModel.fromJson(flavor['name']))
        .toList();

    productInfo.addEntries(reviews.entries);
    ProductModel product =
        ProductModel.fromJson(productInfo, id, flavors: flavors);

    return product;
  }
}
