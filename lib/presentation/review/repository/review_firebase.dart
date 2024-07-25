import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class ReviewFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductReview?> sendReview(
    ReviewState reviewState,
    String productId,
  ) async {
    UserModel user = getIt<SharedPrefsManager>().getUser();
    Map<String, dynamic> reviewJson = {
      "user_id": user.userId,
      "user_name": user.userName,
      "user_profile_pic": user.profilePic,
      "rating": reviewState.rating,
      "note": reviewState.note,
      "flavour_tags": reviewState.selectedFlavors!.map((e) => e.name).toList(),
      "create_date": DateTime.now().toString(),
    };

    DocumentReference<Map<String, dynamic>>? response;

    try {
      var reviewCollection = _firestore
          .collection(CollectionNames.productsCollection)
          .doc(productId)
          .collection(CollectionNames.reviewCollection);

      response = await reviewCollection.add(reviewJson);
    } catch (e) {
      return null;
    }

    reviewJson.addEntries({"id": response.id}.entries);

    ProductReview review = ProductReview.fromJson(reviewJson, productId);

    return review;
  }

  Future<ProductReview?> updateReview(
    ReviewState reviewState,
    String productId,
  ) async {
    UserModel user = getIt<SharedPrefsManager>().getUser();
    Map<String, dynamic> reviewJson = {
      "user_id": user.userId,
      "user_name": user.userName,
      "user_profile_pic": user.profilePic,
      "rating": reviewState.rating,
      "note": reviewState.note,
      "flavour_tags": reviewState.selectedFlavors!.map((e) => e.name).toList(),
      "create_date": DateTime.now().toString(),
    };
    try {
      var reviewCollection = _firestore
          .collection(CollectionNames.productsCollection)
          .doc(productId)
          .collection(CollectionNames.reviewCollection)
          .doc(reviewState.selectedReview!.id);

      await reviewCollection.set(reviewJson);
    } catch (e) {
      return null;
    }

    reviewJson.addEntries({"id": reviewState.selectedReview!.id}.entries);

    ProductReview review = ProductReview.fromJson(reviewJson, productId);

    return review;
  }
}
