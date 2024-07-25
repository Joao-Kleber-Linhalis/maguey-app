import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/custom_loader_widget.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/home/redux/home_actions.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/presentation/shop/redux/shop_actions.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/repository/shop_repo.dart';
import 'package:magueyapp/presentation/shop/ui/screen/all_shops_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/map_view_container.dart';
import 'package:magueyapp/presentation/shop/ui/screen/shops_map_view.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:redux/redux.dart';

class AllShopsBaseScreen extends StatefulWidget {
  static const String route = "all_shops_base_route";
  const AllShopsBaseScreen({super.key});

  @override
  State<AllShopsBaseScreen> createState() => _AllShopsBaseScreenState();
}

class _AllShopsBaseScreenState extends State<AllShopsBaseScreen> {
  final Duration animationDuration = const Duration(milliseconds: 500);
  final Curve curve = Curves.fastEaseInToSlowEaseOut;
  ShopRepo shopRepo = ShopRepo();

  @override
  void initState() {
    shopRepo.getAllShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreBuilder<HomeState>(
        onInit: (store) async => {
          await shopRepo.getCurrentLocation(),
        },
        builder: (context, homeStore) =>
            StoreBuilder<ShopState>(builder: (context, shopStore) {
          switch (shopStore.state.status!) {
            case ResponseStatus.loading:
              return const CustomLoaderWidget();
            case ResponseStatus.success:
              return _buildUi(homeStore, shopStore);
            default:
              return const Center(child: TextView("Error Widget"));
          }
        }),
      ),
    );
  }

  Widget _buildUi(Store<HomeState> homeStore, Store<ShopState> shopStore) {
    return PopScope(
      canPop: homeStore.state.isShopMapViewTap,
      onPopInvoked: (val) async => await onBackButtonPress(homeStore),
      child: Stack(
        children: [
          AnimatedPositioned(
            height: 100.percentHeight(context),
            width: 100.percentWidth(context),
            left: homeStore.state.isShopMapViewTap
                ? 0.percentWidth(context)
                : -100.percentWidth(context),
            duration: animationDuration,
            curve: curve,
            child: AllShopsMapScreen(onListTap: () {
              primaryFocus!.unfocus();
              shopStore.dispatch(OnShopMarkerTapAction(show: false));
              homeStore.dispatch(ToggleMapScreenAction(shopMapTapped: false));
            }, onMarkerTap: (shop) {
              shopStore.dispatch(OnShopMarkerTapAction(shop: shop, show: true));
              shopStore.state.resetSearchFilterApplied = false;
            }),
          ),
          //
          AnimatedPositioned(
            height: 100.percentHeight(context),
            width: 100.percentWidth(context),
            right: !homeStore.state.isShopMapViewTap
                ? 0.percentWidth(context)
                : -100.percentWidth(context),
            duration: animationDuration,
            curve: curve,
            child: AllShopsScreen(
              onLocationTap: (val) {
                homeStore.dispatch(ToggleMapScreenAction(shopMapTapped: true));
              },
              onBackButtonPress: () => onBackButtonPress(homeStore),
            ),
          ),
          if (shopStore.state.selectedShop != null)
            AnimatedPositioned(
              height: 30.percentHeight(context),
              width: 100.percentWidth(context),
              bottom: getBottomPosition(context, shopStore.state),

              // right: !store.state.isMapViewTapped
              //     ? -100.percentWidth(context)
              //     : 0.percentWidth(context),
              duration: animationDuration,
              curve: curve,
              child: MapViewShopTapContainer(
                height: 30.percentHeight(context),
                width: 100.percentWidth(context),
                onClose: () =>
                    shopStore.dispatch(OnShopMarkerTapAction(show: false)),
              ),
            ),
        ],
      ),
    );
  }

  double getBottomPosition(BuildContext context, ShopState shopState) {
    if (shopState.isShopMarkerTapped != null) {
      switch (Theme.of(context).platform) {
        case TargetPlatform.iOS:
          return shopState.isShopMarkerTapped!
              ? 120.pxH(context)
              : -100.percentHeight(context);
        case TargetPlatform.android:
          return shopState.isShopMarkerTapped!
              ? 90.pxH(context)
              : -100.percentHeight(context);
        default:
          return 0.0; // Default value
      }
    }
    return 0.0; // Default value if isShopMarkerTapped is null
  }

  onBackButtonPress(Store<HomeState> store) {
    // if (store.state.isShopMapViewTap) {
    store.dispatch(ToggleMapScreenAction(shopMapTapped: true));
    // }
  }
}
