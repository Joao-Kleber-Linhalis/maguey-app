import 'package:geolocator/geolocator.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class GetActionSelectedEventAction {
  EventModel? event;
  APIsEnum? type;
  ResponseStatus? status;
  String? error;
  GetActionSelectedEventAction({
    this.event,
    this.type,
    this.status,
    this.error,
  });
}

class GetSearchedEventsAction {
  APIsEnum? type;
  ResponseStatus? status;
  String? error;
  List<EventModel>? searchedEvents;
  GetSearchedEventsAction({
    this.type,
    this.status,
    this.error,
    this.searchedEvents,
  });
}

class OnEventMarkerTapAction {
  EventModel? event;
  bool show;

  OnEventMarkerTapAction({this.event, required this.show});
}

class GetCurrentEventLocationAction {
  Position? position;

  GetCurrentEventLocationAction({required this.position});
}

class SearchEventByFiltersAction {}

class SearchEventWithoutAdressAction {}

class ResetSearchFiltersToDefaultAction {}
