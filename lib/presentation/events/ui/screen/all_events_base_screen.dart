import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/custom_loader_widget.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/events/redux/event_action.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/repository/event_repo.dart';
import 'package:magueyapp/presentation/events/ui/screen/all_events_screen.dart';
import 'package:magueyapp/presentation/events/ui/screen/events_map_view.dart';
import 'package:magueyapp/presentation/events/ui/screen/map_view_container.dart';
import 'package:magueyapp/presentation/home/redux/home_actions.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:redux/redux.dart';

class AllEventsBaseScreen extends StatefulWidget {
  static const String route = "all_events_base_route";
  const AllEventsBaseScreen({super.key});

  @override
  State<AllEventsBaseScreen> createState() => _AllEventsBaseScreenState();
}

class _AllEventsBaseScreenState extends State<AllEventsBaseScreen> {
  final Duration animationDuration = const Duration(milliseconds: 500);
  final Curve curve = Curves.fastEaseInToSlowEaseOut;
  EventRepo eventRepo = EventRepo();

  @override
  void initState() {
    eventRepo.getAllEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<HomeState>(
        onInit: (store) async => {
          await eventRepo.getCurrentLocation(),
        },
        builder: (context, homeStore) =>
            StoreBuilder<EventState>(builder: (context, eventStore) {
          switch (eventStore.state.status!) {
            case ResponseStatus.loading:
              return const CustomLoaderWidget();
            case ResponseStatus.success:
              return _buildUi(homeStore, eventStore);
            default:
              return const Center(child: TextView("Error Widget"));
          }
        }),
      ),
    );
  }

  PopScope _buildUi(Store<HomeState> homeStore, Store<EventState> eventStore) {
    return PopScope(
      canPop: homeStore.state.isEventMapViewTap,
      onPopInvoked: (val) async => await onBackButtonPress(homeStore),
      // onWillPop: () async => await onBackButtonPress(store),
      child: Stack(
        children: [
          AnimatedPositioned(
            height: 100.percentHeight(context),
            width: 100.percentWidth(context),
            left: homeStore.state.isEventMapViewTap
                ? 0.percentWidth(context)
                : -100.percentWidth(context),
            duration: animationDuration,
            curve: curve,
            child: AllEventsMapScreen(
              onListTap: () {
                primaryFocus!.unfocus();
                eventStore.dispatch(OnEventMarkerTapAction(show: false));
                homeStore
                    .dispatch(ToggleMapScreenAction(eventMapTapped: false));
              },
              onMarkerTap: (event) {
                eventStore
                    .dispatch(OnEventMarkerTapAction(event: event, show: true));
                eventStore.state.resetSearchFilterApplied = false;
              },
            ),
          ),

          AnimatedPositioned(
            height: 100.percentHeight(context),
            width: 100.percentWidth(context),
            right: !homeStore.state.isEventMapViewTap
                ? 0.percentWidth(context)
                : -100.percentWidth(context),
            duration: animationDuration,
            curve: curve,
            child: AllEventsScreen(
              onLocationTap: (val) {
                homeStore.dispatch(ToggleMapScreenAction(eventMapTapped: true));
              },
              onBackButtonPress: () => onBackButtonPress(homeStore),
            ),
          ),
          if (eventStore.state.selectedEvent != null)
            AnimatedPositioned(
              height: 30.percentHeight(context),
              width: 100.percentWidth(context),
              bottom: getBottomPosition(context, eventStore.state),
              duration: animationDuration,
              curve: curve,
              child: MapViewEventsTapContainer(
                height: 30.percentHeight(context),
                width: 100.percentWidth(context),
                onClose: () =>
                    eventStore.dispatch(OnEventMarkerTapAction(show: false)),
              ),
            ),

          // Center(child: TextView("I am the base screen"))
        ],
      ),
    );
  }

  double getBottomPosition(BuildContext context, EventState eventState) {
    if (eventState.isEventMarkerTapped != null) {
      switch (Theme.of(context).platform) {
        case TargetPlatform.iOS:
          return eventState.isEventMarkerTapped!
              ? 120.pxH(context)
              : -100.percentHeight(context);
        case TargetPlatform.android:
          return eventState.isEventMarkerTapped!
              ? 90.pxH(context)
              : -100.percentHeight(context);
        default:
          return 0.0; // Default value
      }
    }
    return 0.0; // Default value if isShopMarkerTapped is null
  }

  onBackButtonPress(Store<HomeState> store) {
    // if (store.state.isEventMapViewTap) {
    store.dispatch(ToggleMapScreenAction(eventMapTapped: true));
    // }
  }
}
