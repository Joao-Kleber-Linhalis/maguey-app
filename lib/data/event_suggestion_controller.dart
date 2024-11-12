import 'package:flutter/material.dart';

import '../entity/event_suggestion.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class EventSuggestionController {
  final FirebaseController _firebase = FirebaseController();
  final String _collection = NameCollections.eventSuggestions;

  Future<bool> addEventSuggestion(EventSuggestion eventSuggestion) async {
    try {
      String id = eventSuggestion.id;
      if (id == "") {
        id = await _firebase.registerData(
          data: eventSuggestion,
          collection: _collection,
        );
        await _firebase.updateData(
          data: eventSuggestion.copyWith(id: id),
          id: id,
          collection: _collection,
        );
      } else {
        await _firebase.updateData(
          data: eventSuggestion,
          id: id,
          collection: _collection,
        );
      }

      return true;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while signing up user ${e.toString()}{", stackTrace);
    }
  }

  Future<void> deleteEventSuggestion(String eventSuggestionId) async {
    try {
      await _firebase.deleteData(
        collection: _collection,
        id: eventSuggestionId,
      );
    } catch (e) {
      debugPrint("Error while deleting event suggestion: ${e.toString()}");
    }
  }

  Future<void> updateEventSuggestion(EventSuggestion eventSuggestion) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: eventSuggestion.id,
        data: eventSuggestion,
      );
    } catch (e, stackTrace) {
      return Future.error(
          "Error while updating event suggestion: ${e.toString()}", stackTrace);
    }
  }

  Future<EventSuggestion> searchEventSuggestion(
      String eventSuggestionId) async {
    try {
      final data = await _firebase.searchData(
        collection: _collection,
        id: eventSuggestionId,
      );
      return EventSuggestion.fromJson(data);
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for event suggestion: ${e.toString()}", stackTrace);
    }
  }

  Future<List<EventSuggestion>> searchAllEventSuggestions() async {
    try {
      final data = await _firebase.searchAllData(collection: _collection);
      List<EventSuggestion> eventSuggestions = [];
      for (var i in data) {
        eventSuggestions.add(EventSuggestion.fromJson(i));
      }
      return eventSuggestions;
    } catch (e, stackTrace) {
      return Future.error(
          "Error searching for event suggestions: ${e.toString()}", stackTrace);
    }
  }
}
