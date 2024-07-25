import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/common/functions/no_internet_toast.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/redux/event_action.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/repository/event_firebase.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/connectivity_service/connectivity_service.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:redux/redux.dart';

class EventRepo {
  Store<EventState> store = StoreProvider.of<EventState>(
    GlobalContext.currentContext!,
    listen: false,
  );
  EventFirebase eventFirebase = EventFirebase();
  Future<void> getAllEvents() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(ActionGet(
        type: APIsEnum.event,
        status: ResponseStatus.loading,
        payloadData: [],
      ));

      List<EventModel> events = await eventFirebase.getEventsFromFirebase();

      store.dispatch(ActionGet(
        payloadData: events,
        type: APIsEnum.event,
        status: ResponseStatus.success,
      ));
    } else {
      noInternetToast();
    }
  }

  Future<double> getDifferenceInMeters(
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) async {
    return Geolocator.distanceBetween(lat1, long1, lat2, long2) / 100;
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position pos = await Geolocator.getCurrentPosition();

      store.dispatch(GetCurrentEventLocationAction(position: pos));
    } else {
      store.dispatch(GetCurrentEventLocationAction(position: null));
    }
  }

  Future<void> getSelectedShop() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(GetActionSelectedEventAction(
        type: APIsEnum.event,
        status: ResponseStatus.loading,
        event: store.state.selectedEvent,
      ));

      if (store.state.selectedEvent == null) {
        store.dispatch(GetActionSelectedEventAction(
          type: APIsEnum.event,
          status: ResponseStatus.error,
          error: "Event id not selected",
        ));
      } else {
        EventModel event = await eventFirebase.getSelectedEvent(
          id: store.state.selectedEvent!.id,
        );

        store.dispatch(GetActionSelectedEventAction(
          event: event,
          type: APIsEnum.product,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }

  Future<void> getSearchedEvents({
    required String? query,
  }) async {
    if (await ConnectivityService.connected()) {
      if (query == null || query.isEmpty) {
      } else {
        store.dispatch(GetSearchedEventsAction(
          type: APIsEnum.event,
          status: ResponseStatus.loading,
          searchedEvents: null,
        ));

        List<EventModel> events =
            await eventFirebase.getSearchedEvents(query: query);

        store.dispatch(GetSearchedEventsAction(
          searchedEvents: events,
          type: APIsEnum.event,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }
}
