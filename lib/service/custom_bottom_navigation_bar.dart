import 'package:flutter/material.dart';

class CustomBottomNavigationBarService {
  CustomBottomNavigationBarService._();

  static CustomBottomNavigationBarService? _instance;
  static CustomBottomNavigationBarService get instance {
    _instance ??= CustomBottomNavigationBarService._();
    return _instance!;
  }

  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  void setCurrentIndex(index) {
    if (currentIndexNotifier.value == index) currentIndexNotifier.value = -1;
    currentIndexNotifier.value = index;
  }
}
