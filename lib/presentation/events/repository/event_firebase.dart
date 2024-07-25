import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';

class EventFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventModel>> getEventsFromFirebase() async {
    var data =
        await _firestore.collection(CollectionNames.eventCollection).get();

    List<EventModel> events =
        data.docs.map((e) => EventModel.fromJson(e.data(), e.id)).toList();
    return events;
  }

  Future<List<EventModel>> getSearchedEvents({
    required String query,
  }) async {
    var data =
        await _firestore.collection(CollectionNames.eventCollection).get();

    List<EventModel> events = data.docs
        .map((event) => EventModel.fromJson(event.data(), event.id))
        .where(
            (event) => event.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return events;
  }

  Future<EventModel> getSelectedEvent({
    required String id,
  }) async {
    // Getting the base product info
    var doc = await _firestore
        .collection(CollectionNames.eventCollection)
        .doc(id)
        .get();

    EventModel event = EventModel.fromJson(doc.data()!, doc.id);
    return event;
  }
}
