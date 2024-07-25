import 'package:flutter/cupertino.dart';
import 'package:magueyapp/presentation/events/ui/screen/all_events_base_screen.dart';
import 'package:magueyapp/presentation/favourites/ui/screen/favourites.dart';
import 'package:magueyapp/presentation/home/redux/home_actions.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/presentation/home/ui/screen/home_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/all_shops_base_screen.dart';

import 'package:redux/redux.dart';

final homeStore = Store<HomeState>(
  homeReducer,
  initialState: HomeState(
    currentBtmIndex: 0,
    isShopMapViewTap: true,
    isEventMapViewTap: true,
    navDuration: const Duration(milliseconds: 400),
    navCurve: Curves.fastEaseInToSlowEaseOut,
    screenList: const [
      MyHomePage(),
      AllShopsBaseScreen(),
      AllEventsBaseScreen(),
      FavouritesScreen(),
    ],
  ), // Initial state
);

HomeState homeReducer(HomeState newState, dynamic action) {
  if (action is NavigationAction) {
    navigateToTheScreen(action.index, homeStore.state);
    // Shop Tapped
  }

  if (action is ToggleMapScreenAction) {
    toggleMapViewTapped(action, homeStore.state.currentBtmIndex);
  }

  return newState;
}

toggleMapViewTapped(ToggleMapScreenAction action, int currentIndex) {
  if (action.shopMapTapped != null) {
    homeStore.state.isShopMapViewTap = action.shopMapTapped!;
  }

  // else {
  //   bool value = currentIndex == 1
  //       ? !homeStore.state.isShopMapViewTap
  //       : !homeStore.state.isEventMapViewTap;
  //   homeStore.state.isShopMapViewTap = value;
  // }

  if (action.eventMapTapped != null) {
    homeStore.state.isEventMapViewTap = action.eventMapTapped!;
  }

  // else {
  //   bool value = currentIndex == 1
  //       ? !homeStore.state.isShopMapViewTap
  //       : !homeStore.state.isEventMapViewTap;
  //   homeStore.state.isEventMapViewTap = value;
  // }
}

navigateToTheScreen(int index, HomeState state) {
  if (state.pageController != null) {
    if ((index - homeStore.state.currentBtmIndex).abs() > 1) {
      state.currentBtmIndex = index;
      homeStore.state.pageController!.jumpToPage(
        state.currentBtmIndex,
        // duration: duration,
        // curve: curve,
      );
    } else if (homeStore.state.currentBtmIndex != index) {
      state.currentBtmIndex = index;
      homeStore.state.pageController!.animateToPage(
        state.currentBtmIndex,
        duration: state.navDuration!,
        curve: state.navCurve,
      );
    }
    // state.pageController!.animateToPage(
    //   index,
    //   duration: state.navDuration!,
    //   curve: state.navCurve,
    // );
  }
}
