import 'package:flutter/material.dart';

class HomeState {
  String? name;
  String? error;
  int currentBtmIndex = 0;
  PageController? pageController;
  late bool isShopMapViewTap, isEventMapViewTap;
  Duration? navDuration;
  late Curve navCurve;
  late List<Widget> screenList;

  HomeState({
    this.name,
    required this.currentBtmIndex,
    required this.screenList,
    required this.isShopMapViewTap,
    required this.isEventMapViewTap,
    this.pageController,
    required this.navDuration,
    required this.navCurve,
  });

  HomeState.formState(HomeState newState) {
    name = newState.name;
    error = newState.error;
    pageController = newState.pageController;
    screenList = newState.screenList;
    isShopMapViewTap = newState.isShopMapViewTap;
    isEventMapViewTap = newState.isEventMapViewTap;
    currentBtmIndex = newState.currentBtmIndex;
    navDuration = newState.navDuration;
    navCurve = newState.navCurve;
  }

  String? get viewName => name;

  String? get viewError => error;

  int get currentIndex => currentBtmIndex;
  PageController? get pgController => pageController;

  bool get allowMapScrolling => (isShopMapViewTap && currentBtmIndex == 1 ||
      isEventMapViewTap && currentBtmIndex == 2);
}
