import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/redux/event_action.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

import 'package:redux/redux.dart';

final eventStore = Store<EventState>(
  eventReducer,
  initialState: EventState(
    eventList: [],
    selectedEvent: null,
    eventSearchList: null,
    status: ResponseStatus.loading,
    isEventMarkerTapped: false,
    currentLocation: null,
    selectedRange: 30.0,
    recentSearch: "",
    // eventSearchFilters: [],
    isSearchFilterApplied: false,
    isSearchedWithoutAddress: false,
    defaultCoordinates: null,
    zoom: 11.0,
    resetSearchFilterApplied: false,
  ), // Initial state
);

EventState eventReducer(EventState newState, dynamic action) {
  if (action is ActionGet) {
    newState = _getAllEventsState(action, newState);
  } else if (action is OnEventMarkerTapAction) {
    newState.isEventMarkerTapped = action.show;
    newState.selectedEvent = action.event;
  } else if (action is GetCurrentEventLocationAction) {
    newState.currentLocation = action.position;
  } else if (action is SearchEventByFiltersAction) {
    newState.isSearchFilterApplied = true;
    newState.isSearchedWithoutAddress = false;
    newState.resetSearchFilterApplied = false;
  } else if (action is SearchEventWithoutAdressAction) {
    newState.isSearchedWithoutAddress = true;
    newState.resetSearchFilterApplied = false;
  } else if (action is ResetSearchFiltersToDefaultAction) {
    //newState.defaultCoordinates = null;
    newState.isSearchFilterApplied = false;
    newState.isSearchedWithoutAddress = false;
    newState.recentSearch = "";
    newState.selectedRange = 30.0;
    newState.zoom = 11.0;
    newState.resetSearchFilterApplied = true;
  }

  return newState;
}

EventState _getAllEventsState(ActionGet action, EventState state) {
  state.status = action.status;
  state.type = action.type;
  state.error = action.error;
  state.isEventMarkerTapped = false;
  state.selectedEvent = null;

  if (action.status == ResponseStatus.success) {
    state.eventList = action.payloadData as List<EventModel>;
  } else if (action.status == ResponseStatus.loading) {
    state.eventList = [];
  } else {
    state.eventList = null;
  }

  return state;
}
