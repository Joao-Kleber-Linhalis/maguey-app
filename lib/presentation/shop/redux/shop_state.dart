import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/places_auto_search/google_place_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class ShopState {
  String? error;
  List<ShopModel>? shopsList;
  List<ShopModel>? shopSearchList;
  ShopModel? selectedShop;
  ResponseStatus? status;
  APIsEnum? type;
  bool? isShopMarkerTapped;
  Position? currentLocation;

  // Searching Data
  String? recentSearch;
  bool? isSearchFilterApplied;
  bool? isSearchedWithoutAddress;
  double? selectedRange;
  GoogleSuggestion? placeSearchResult;
  List<String>? shopSearchFilters;
  LatLng? defaultCoordinates;
  bool? resetSearchFilterApplied;
  double? zoom;

  ShopState({
    required this.shopsList,
    required this.selectedShop,
    required this.shopSearchList,
    required this.currentLocation,
    required this.isShopMarkerTapped,
    required this.shopSearchFilters,
    this.recentSearch,
    this.selectedRange,
    this.placeSearchResult,
    this.isSearchFilterApplied,
    this.error,
    this.status,
    this.type,
    this.isSearchedWithoutAddress,
    this.defaultCoordinates,
    this.resetSearchFilterApplied,
    this.zoom,
  });

  ShopState.formState(ShopState newState) {
    error = newState.error;
    shopSearchList = newState.shopSearchList;
    shopsList = newState.shopsList;
    selectedShop = newState.selectedShop;
    status = newState.status;
    type = newState.type;
    isShopMarkerTapped = newState.isShopMarkerTapped;
    recentSearch = newState.recentSearch;
    selectedRange = newState.selectedRange;
    placeSearchResult = newState.placeSearchResult;
    shopSearchFilters = newState.shopSearchFilters;
    isSearchFilterApplied = newState.isSearchFilterApplied;
    isSearchedWithoutAddress = newState.isSearchedWithoutAddress;
    defaultCoordinates = newState.defaultCoordinates;
    resetSearchFilterApplied = newState.resetSearchFilterApplied!;
    zoom = newState.zoom!;
  }
}
