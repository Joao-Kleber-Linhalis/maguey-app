import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entity/entity.dart';

class FirebaseController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    print(auth.currentUser?.uid);
    return auth.currentUser;
  }

  Future<void> SavePdfFile(
    File file,
    String id,
  ) async {
    try {
      int number = Random().nextInt(100);
      final fileRef = storageRef.child("$id/$number.pdf");
      await fileRef.putData(file.readAsBytesSync());
    } catch (e) {
      return Future.error(e, StackTrace.current);
    }
  }

  Future<List<String>> getFilesFromPath(String id) async {
    List<String> files = [];
    try {
      final fileRef = storageRef.child(id);
      final list = await fileRef.listAll();
      for (var item in list.items) {
        final url = await item.getDownloadURL();

        files.add(url);
      }
    } catch (e) {
      return Future.error(e, StackTrace.current);
    }
    return files;
  }

  Future<String> saveImageGetURLBack(Uint8List image,
      {String id = '', String path = '', String collection = ''}) async {
    if (id.isEmpty || path.isEmpty) {
      return Future.error("Invalid data", StackTrace.current);
    }

    final imageRef = storageRef.child("$id/$path");
    try {
      // final blob = await image.readAsString();
      await imageRef.putData(
          image,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      String url = await imageRef.getDownloadURL();
      return url;
    } catch (e) {
      return Future.error(e, StackTrace.current);
    }
  }

  Future<List<Map<String, dynamic>>> searchCollection(
      {String collection = ''}) async {
    if (collection.isEmpty) {
      return Future.error("Invalid collection to search", StackTrace.current);
    }
    List<Map<String, dynamic>> list = [];
    try {
      await _db.collection(collection).get().then((event) {
        for (var doc in event.docs) {
          list.add(doc.data());
        }
      });
      return list;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<Map<String, dynamic>> searchData(
      {String collection = '', String id = ''}) async {
    if (id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to search", StackTrace.current);
    }
    try {
      final response = await _db.collection(collection).doc(id).get();
      if (response.exists && response.data() != null) {
        Map<String, dynamic> dataWithId = {
          'id': response.id, // Include the document ID
          ...response.data()!, // Spread the existing data
        };
        return dataWithId;
      }
      return Future.error("Data not found in $collection", StackTrace.current);
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<bool> searchDataExist({String collection = '', String id = ''}) async {
    if (id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to search", StackTrace.current);
    }

    try {
      final response = await _db.collection(collection).doc(id).get();
      if (response.exists && response.data() != null) {
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<List<Map<String, dynamic>>> searchAllData(
      {required String collection}) async {
    if (collection.isEmpty) {
      throw Exception("Invalid collection name");
    }
    try {
      final querySnapshot = await _db.collection(collection).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        throw Exception("No documents found in $collection");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> searchDataWithCondition(
      {String collection = '', dynamic condName = '', String cond = ''}) async {
    if (cond.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to search", StackTrace.current);
    }
    try {
      List<Map<String, dynamic>> res = [];
      final response = await _db
          .collection(collection)
          .where(condName, isEqualTo: cond)
          .get();
      for (var element in response.docs) {
        if (element.exists) {
          Map<String, dynamic> dataWithId = {
            'id': element.id,
            ...element.data(),
          };
          res.add(dataWithId);
        }
      }

      return res;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Stream<List<Map<String, dynamic>>> streamDataWithCondition({
    String collection = '',
    dynamic condName = '',
    String cond = '',
  }) {
    if (cond.isEmpty || collection.isEmpty) {
      return Stream.error("Invalid data to search");
    }

    try {
      return _db
          .collection(collection)
          .where(condName, isEqualTo: cond)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .where((doc) => doc.exists)
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      debugPrint("Error streaming data: $e");

      return Stream.empty();
    }
  }

  Future<void> updateMapData(
      {String collection = '',
      String id = '',
      Map<String, dynamic>? data}) async {
    if (data == null || id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to update", StackTrace.current);
    }
    try {
      await _db
          .collection(collection)
          .doc(id)
          .update(data); // Use update() instead of set() for a partial update
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<void> updateData(
      {String collection = '', String id = '', Entity? data}) async {
    if (data == null || id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to update", StackTrace.current);
    }
    try {
      var json = data.toJson();
      json["updatedAt"] = DateTime.now();
      await _db
          .collection(collection)
          .doc(id)
          .set(json, SetOptions(merge: true));
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<void> updateAccountData(
      {String collection = '', String id = '', double? data}) async {
    if (data == null || id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to update", StackTrace.current);
    }
    try {
      await _db
          .collection(collection)
          .doc(id)
          .update({'account_balance': data});
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<void> deleteData({String collection = '', String id = ''}) async {
    if (id.isEmpty || collection.isEmpty) {
      return Future.error("Invalid data to delete", StackTrace.current);
    }
    try {
      await _db.collection(collection).doc(id).delete();
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<String> registerData({Entity? data, String? collection}) async {
    if (data == null || collection == null || collection.isEmpty) {
      return Future.error("Invalid data to register", StackTrace.current);
    }
    try {
      var json = data.toJson();
      json["createdAt"] = DateTime.now();
      final response = await _db.collection(collection).add(json);

      return response.id;
    } catch (e, stackTrace) {
      return Future.error("Error when registering", stackTrace);
    }
  }

  Future<void> updateSpecificData(
      {String collection = '',
      String id = '',
      Map<String, Object>? data}) async {
    if (data == null || id.isEmpty || collection.isEmpty) {
      return Future.error("Dados Inváidos para atualizar", StackTrace.current);
    }
    try {
      data['updatedAt'] = Timestamp.now();
      await _db.collection(collection).doc(id).update(data);
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }
}
