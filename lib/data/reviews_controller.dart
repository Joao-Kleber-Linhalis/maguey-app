import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../entity/category_entity.dart';
import '../entity/review_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class ReviewsController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.reviewsCollection;

  Future<bool> addReview(ReviewEntity review) async {
    try {
      String id = review.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: review,
          collection: _collection,
        );
        await _firebase.updateData(
          data: review.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: review,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error("Error while signing up user ${e.toString()}{", stackTrace);
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: reviewId,
      );
    } catch (e) {
      print("Error while deleting category: ${e.toString()}");
    }
  }

  Future<void> updateReview(ReviewEntity review) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: review.id,
        data: review,
      );
    } catch (e, stackTrace) {
      return Future.error("Error while updating category: ${e.toString()}", stackTrace);
    }
  }

  Future<Category> searchReview(String reviewId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: reviewId,
      );
      return Category.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error("Error searching for category: ${e.toString()}", stackTrace);
    }
  }

  Future<List<ReviewEntity>> searchAllReviews() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<ReviewEntity> reviews = [];
      for (var i in data) {
        reviews.add(ReviewEntity.fromJson(i));
      }

      return reviews;
    } catch (e, stackTrace) {
      return Future.error("Error searching for brand: ${e.toString()}", stackTrace);
    }
  }

  Stream<List<ReviewEntity>> streamAllReviews() {
    return FirebaseFirestore.instance.collection('reviews').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return ReviewEntity.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      },
    );
  }

  Future<String> uploadPhoto(String path, File image, String folder) async {
    final firebaseStorageRef = FirebaseStorage.instance.ref().child('$folder/$path');
    final uploadTask = firebaseStorageRef.putFile(image);
    await uploadTask.whenComplete(() {});
    return uploadTask.snapshot.ref.getDownloadURL();
  }
}
