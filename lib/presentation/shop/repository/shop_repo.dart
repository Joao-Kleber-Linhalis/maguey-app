import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/common/functions/no_internet_toast.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/redux/shop_actions.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/repository/shop_firebase.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/connectivity_service/connectivity_service.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:redux/redux.dart';

class ShopRepo {
  Store<ShopState> store = StoreProvider.of<ShopState>(
    GlobalContext.currentContext!,
    listen: false,
  );
  ShopFirebase shopFirebase = ShopFirebase();
  Future<void> getAllShops() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(ActionGet(
        type: APIsEnum.shop,
        status: ResponseStatus.loading,
        payloadData: [],
      ));

      List<ShopModel> products = await shopFirebase.getShopsFromFirebase();

      store.dispatch(ActionGet(
        payloadData: products,
        type: APIsEnum.shop,
        status: ResponseStatus.success,
      ));
    } else {
      noInternetToast();
    }
  }

  Future<double> getDifferenceInMeters(
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) async {
    return Geolocator.distanceBetween(lat1, long1, lat2, long2) / 100;
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position pos = await Geolocator.getCurrentPosition();

      store.dispatch(GetCurrentLocationAction(position: pos));
    } else {
      store.dispatch(GetCurrentLocationAction(position: null));
    }
  }

  Future<void> getSelectedShop() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(GetActionSelectedShopAction(
        type: APIsEnum.shop,
        status: ResponseStatus.loading,
        shop: store.state.selectedShop,
      ));

      if (store.state.selectedShop == null) {
        store.dispatch(GetActionSelectedShopAction(
          type: APIsEnum.product,
          status: ResponseStatus.error,
          error: "Product id not selected",
        ));
      } else {
        ShopModel shop = await shopFirebase.getSelectedShop(
          id: store.state.selectedShop!.id,
        );

        store.dispatch(GetActionSelectedShopAction(
          shop: shop,
          type: APIsEnum.product,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }

  Future<void> getSearchedShops({
    required String? query,
  }) async {
    if (await ConnectivityService.connected()) {
      if (query == null || query.isEmpty) {
      } else {
        store.dispatch(GetSearchedShopsAction(
          type: APIsEnum.shop,
          status: ResponseStatus.loading,
          searchedShops: null,
        ));

        List<ShopModel> shops =
            await shopFirebase.getSearchedShops(query: query);

        store.dispatch(GetSearchedShopsAction(
          searchedShops: shops,
          type: APIsEnum.shop,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }
}
