import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/functions/distance_calculate.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/filter_icon.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/redux/event_action.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/redux/reducer.dart';
import 'package:magueyapp/presentation/events/ui/screen/events_details_screen.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_filter_tap.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_list_tile.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/map_view_icon_button.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:redux/redux.dart';

class AllEventsScreen extends StatelessWidget {
  static const String route = "all_events_screen";
  final Function()? onBackButtonPress;
  final Function(bool)? onLocationTap;
  const AllEventsScreen({
    super.key,
    this.onLocationTap,
    this.onBackButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(
        title: "Event Lists",
        leadingWidget: null,
        // showBackButton: false,
        onTapOfBackButton: () {
          if (onBackButtonPress != null) onBackButtonPress!();
        },
        actionsWidget: [
          FilterIcon(onSearchTap: () => onEventFilterTap(context)),
          MapViewIconButton(
            onTap: () {
              if (onLocationTap != null) onLocationTap!(true);
            },
          ),
        ],
      ),
      body: StoreBuilder<EventState>(
        builder: (context, eventStore) => SizedBox(
          height: 100.percentHeight(context),
          child: events(eventStore).isEmpty
              ? const Center(
                  child: TextView("No events are available"),
                )
              : ListView.builder(
                  itemCount: events(eventStore).length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<EventModel> list = events(eventStore);
                    return EventListTile(
                      event: EventModel(
                          id: list[index].id,
                          name: list[index].name,
                          imageUrl: list[index].imageUrl,
                          eventLocation: list[index].eventLocation,
                          startTime: list[index].startTime,
                          endTime: list[index].endTime,
                          createDate: list[index].createDate,
                          description: list[index].description,
                          eventDate: list[index].eventDate,
                          price: list[index].price,
                          eventLink: list[index].eventLink),
                      onTap: (event) {
                        eventStore.dispatch(OnEventMarkerTapAction(
                            event: list[index], show: false));
                        context.pushNamed(EventsDetailsScreen.route);
                      },
                      topMargin: index == 0 ? 16 : 0,
                      bottomMargin: index == list.length - 1 ? 200 : 16,
                    );
                  },
                ),
        ),
      ),
    );
  }

  List<EventModel> events(Store<EventState> store) =>
      store.state.isSearchFilterApplied! ||
              store.state.isSearchedWithoutAddress!
          ? getFilterdEvents()
          : eventStore.state.eventList!;

  List<EventModel> getFilterdEvents() {
    List<EventModel> list = [];
    double lat = 0; //double.parse(eventStore.state.placeSearchResult!.lat!);
    double lng = 0; //double.parse(eventStore.state.placeSearchResult!.lng!);

    if (eventStore.state.isSearchedWithoutAddress!) {
      lat = eventStore.state.defaultCoordinates!.latitude;
      lng = eventStore.state.defaultCoordinates!.longitude;
    } else {
      lat = double.parse(eventStore.state.placeSearchResult!.lat!);
      lng = double.parse(eventStore.state.placeSearchResult!.lng!);
    }

    if (eventStore.state.eventList != null) {
      for (EventModel shop in eventStore.state.eventList!) {
        if (shop.eventLocation.latitude != null &&
            shop.eventLocation.longitude != null) {
          if (eventStore.state.selectedRange! >=
              calculateDistance(lat, lng, shop.eventLocation.latitude,
                  shop.eventLocation.longitude)) {
            // if (eventStore.state.eventSearchFilters!.isEmpty) {
            list.add(shop);
            // }
            // else if (eventStore.state.eventSearchFilters!
            //     .contains(shop.shopType)) {
            //   list.add(shop);
            // }
          }
        }
      }
    }
    return list;
  }
}
