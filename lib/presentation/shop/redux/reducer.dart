import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/redux/shop_actions.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

import 'package:redux/redux.dart';

final shopStore = Store<ShopState>(
  shopReducer,
  initialState: ShopState(
    shopsList: [],
    selectedShop: null,
    shopSearchList: null,
    status: ResponseStatus.loading,
    isShopMarkerTapped: false,
    currentLocation: null,
    selectedRange: 30,
    recentSearch: "",
    shopSearchFilters: [],
    isSearchFilterApplied: false,
    isSearchedWithoutAddress: false,
    defaultCoordinates: null,
    resetSearchFilterApplied: false,
    zoom: 11.0,
  ), // Initial state
);

ShopState shopReducer(ShopState newState, dynamic action) {
  if (action is ActionGet) {
    newState = _getAllProductsState(action, newState);
  } else if (action is OnShopMarkerTapAction) {
    newState.isShopMarkerTapped = action.show;
    newState.selectedShop = action.shop;
  } else if (action is GetCurrentLocationAction) {
    newState.currentLocation = action.position;
  } else if (action is SearchShopByFiltersAction) {
    newState.shopSearchFilters = action.shopTypes;
    newState.isSearchFilterApplied = true;
    newState.isSearchedWithoutAddress = false;
    newState.resetSearchFilterApplied = false;
  } else if (action is SearchShopWithoutAdressAction) {
    newState.isSearchedWithoutAddress = true;
    newState.resetSearchFilterApplied = false;
  } else if (action is ResetSearchFiltersToDefaultAction) {
    // newState.defaultCoordinates = null;
    newState.isSearchFilterApplied = false;
    newState.isSearchedWithoutAddress = false;
    newState.recentSearch = "";
    newState.selectedRange = 30.0;
    newState.shopSearchFilters = [];
    newState.resetSearchFilterApplied = true;
    newState.zoom = 11.0;
  }

  return newState;
}

ShopState _getAllProductsState(ActionGet action, ShopState state) {
  state.status = action.status;
  state.type = action.type;
  state.error = action.error;
  state.isShopMarkerTapped = false;
  state.selectedShop = null;

  if (action.status == ResponseStatus.success) {
    state.shopsList = action.payloadData as List<ShopModel>;
  } else if (action.status == ResponseStatus.loading) {
    state.shopsList = [];
  } else {
    state.shopsList = null;
  }

  return state;
}
