import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/entity.dart';

class FetchDataStreamDocuments<E extends Entity> {
  Stream<List<E>> fetchStream({required String collection, required Function({required Map<String, dynamic> data}) filteringParameters}) {
    CollectionReference accountsCollection = FirebaseFirestore.instance.collection(collection);
    return accountsCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map<E>((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return filteringParameters(data: data);
      }).toList();
    });
  }

  Stream<List<E>> fetchStreamWithParametersPassingListParameters(
      {required String collection,
      required String parameter,
      required List<String> value,
      required Function({required Map<String, dynamic> data}) createEntity}) {
    Query<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection(collection).where(parameter, whereIn: value);
    return querySnapshot.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map<E>((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return createEntity(data: data);
          })
          .where((account) => account.id.isNotEmpty)
          .toList();
    });
  }

  Stream<List<E>> fetchStreamWithSingleParameter(
      {required String collection, required String parameter, required value, required Function({required Map<String, dynamic> data}) createEntity}) {
    Query<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection(collection).where(parameter, isEqualTo: value);
    return querySnapshot.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map<E>((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return createEntity(data: data);
      }).toList();
    });
  }

  Stream<List<E>> fetchStreamWithSingleParameterOrdered({
    required String collection,
    required String parameter,
    required value,
    required Function({required Map<String, dynamic> data}) createEntity,
    required String orderBy,
    required bool ascending,
  }) {
    Query<Map<String, dynamic>> querySnapshot =
        FirebaseFirestore.instance.collection(collection).where(parameter, isEqualTo: value).orderBy(orderBy, descending: ascending);
    return querySnapshot.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map<E>((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return createEntity(data: data);
      }).toList();
    });
  }
}
