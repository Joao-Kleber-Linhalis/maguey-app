import 'package:magueyapp/base_redux/base_action.dart';

class NavigationAction extends Action {
  int index; // The screen index where you wanna navigate

  NavigationAction({required this.index}) : super();
}

class ToggleMapScreenAction extends Action {
  bool? shopMapTapped;
  bool? eventMapTapped;
  ToggleMapScreenAction({this.shopMapTapped, this.eventMapTapped}) : super();
}
