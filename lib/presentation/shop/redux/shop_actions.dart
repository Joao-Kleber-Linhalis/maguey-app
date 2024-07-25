import 'package:geolocator/geolocator.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class GetActionSelectedShopAction {
  ShopModel? shop;
  APIsEnum? type;
  ResponseStatus? status;
  String? error;
  GetActionSelectedShopAction({
    this.shop,
    this.type,
    this.status,
    this.error,
  });
}

class GetSearchedShopsAction {
  APIsEnum? type;
  ResponseStatus? status;
  String? error;
  List<ShopModel>? searchedShops;
  GetSearchedShopsAction({
    this.type,
    this.status,
    this.error,
    this.searchedShops,
  });
}

class OnShopMarkerTapAction {
  ShopModel? shop;
  bool show;

  OnShopMarkerTapAction({this.shop, required this.show});
}

class GetCurrentLocationAction {
  Position? position;

  GetCurrentLocationAction({required this.position});
}

class SearchShopByFiltersAction {
  // double lat;
  // double lng;
  // int range;
  List<String> shopTypes;

  SearchShopByFiltersAction({
    // required this.lat,
    // required this.lng,
    // required this.range,
    required this.shopTypes,
  });
}

class SearchShopWithoutAdressAction {
  // LatLng defaultCoordinates;
  // SearchShopWithoutAdressAction({
  //   required this.defaultCoordinates
  // }
  //  );
}

class ResetSearchFiltersToDefaultAction {}
