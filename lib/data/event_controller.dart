import 'package:flutter/material.dart';

import '../entity/event_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class EventController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.eventsCollection;

  Future<bool> addEvent(EventEntity event) async {
    try {
      String id = event.id;
      if (id.isEmpty) {
        id = await _firebase.registerData(
          data: event,
          collection: _collection,
        );
        await _firebase.updateData(
          data: event.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: event,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while adding event: ${e.toString()}", stackTrace);
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: eventId,
      );
    } catch (e) {
      debugPrint("Error while deleting event: ${e.toString()}");
    }
  }

  Future<void> updateEvent(EventEntity event) async {
    try {
      await _firebase.updateData(
        data: event,
        id: event.id,
        collection: _collection,
      );
    } catch (e, stackTrace) {
      return Future.error(
          "Error while updating event: ${e.toString()}", stackTrace);
    }
  }

  Future<EventEntity> searchEvent(String eventId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: eventId,
      );
      return EventEntity.fromJson(
          data); // Assuming there's a fromJson constructor
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for event: ${e.toString()}", stackTrace);
    }
  }

  Future<List<EventEntity>> searchAllEvents() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<EventEntity> events = [];
      for (var i in data) {
        events.add(EventEntity.fromJson(i));
      }
      return events;
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for events: ${e.toString()}", stackTrace);
    }
  }
}
