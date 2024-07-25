import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/places_auto_search/google_place_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class EventState {
  String? error;
  List<EventModel>? eventList;
  List<EventModel>? eventSearchList;
  EventModel? selectedEvent;
  ResponseStatus? status;
  APIsEnum? type;
  bool? isEventMarkerTapped;
  Position? currentLocation;

  // Searching Data
  String? recentSearch;
  bool? isSearchFilterApplied;
  bool? isSearchedWithoutAddress;
  bool? resetSearchFilterApplied;
  double? selectedRange;
  GoogleSuggestion? placeSearchResult;
  LatLng? defaultCoordinates;
  double? zoom;
  //List<String>? eventSearchFilters;

  EventState({
    required this.eventList,
    required this.selectedEvent,
    required this.eventSearchList,
    required this.currentLocation,
    required this.isEventMarkerTapped,
    //required this.eventSearchFilters,
    this.recentSearch,
    this.selectedRange,
    this.placeSearchResult,
    this.isSearchFilterApplied,
    this.error,
    this.status,
    this.type,
    this.isSearchedWithoutAddress,
    this.defaultCoordinates,
    this.zoom,
    this.resetSearchFilterApplied,
  });

  EventState.formState(EventState newState) {
    error = newState.error;
    eventSearchList = newState.eventSearchList;
    eventList = newState.eventList;
    selectedEvent = newState.selectedEvent;
    status = newState.status;
    type = newState.type;
    isEventMarkerTapped = newState.isEventMarkerTapped;
    recentSearch = newState.recentSearch;
    selectedRange = newState.selectedRange;
    placeSearchResult = newState.placeSearchResult;
    // eventSearchFilters = newState.eventSearchFilters;
    isSearchFilterApplied = newState.isSearchFilterApplied;
    isSearchedWithoutAddress = newState.isSearchedWithoutAddress!;
    defaultCoordinates = newState.defaultCoordinates;
    zoom = newState.zoom!;
    resetSearchFilterApplied = newState.resetSearchFilterApplied!;
  }
}
