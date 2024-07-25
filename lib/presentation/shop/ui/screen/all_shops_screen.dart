import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/functions/distance_calculate.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/filter_icon.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/redux/reducer.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shop_filter_tap.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shop_list_tile.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/map_view_icon_button.dart';
import 'package:redux/redux.dart';

class AllShopsScreen extends StatefulWidget {
  static const String route = "all_shops";
  final Function()? onBackButtonPress;
  final Function(bool)? onLocationTap;
  const AllShopsScreen({
    super.key,
    this.onLocationTap,
    this.onBackButtonPress,
  });

  @override
  State<AllShopsScreen> createState() => _AllShopsScreenState();
}

class _AllShopsScreenState extends State<AllShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(
        title: "Shop Lists",
        leadingWidget: null,
        // showBackButton: false,
        onTapOfBackButton: () {
          if (widget.onBackButtonPress != null) widget.onBackButtonPress!();
        },
        actionsWidget: [
          FilterIcon(
              onSearchTap: () => onShopFilterTap(
                    context,
                    // (x, y) {}
                  )),
          MapViewIconButton(
            onTap: () {
              if (widget.onLocationTap != null) widget.onLocationTap!(true);
            },
          ),
        ],
      ),
      body: StoreBuilder<ShopState>(
        builder: (context, shopStore) => SizedBox(
          height: 100.percentHeight(context),
          child: shops(shopStore).isEmpty
              ? const Center(
                  child: TextView("No shops are available"),
                )
              : ListView.builder(
                  itemCount: shops(shopStore).length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<ShopModel> list = shops(shopStore);
                    return ShopListTile(
                      shop: list[index],
                      topMargin: index == 0 ? 16 : 0,
                      bottomMargin: index == list.length - 1 ? 100 : 16,
                    );
                  }),
        ),
      ),
    );
  }

  List<ShopModel> shops(Store<ShopState> store) =>
      store.state.isSearchFilterApplied! ||
              store.state.isSearchedWithoutAddress!
          ? getFilterdShops()
          : shopStore.state.shopsList!;

  List<ShopModel> getFilterdShops() {
    List<ShopModel> list = [];
    double lat = 0.0;
    double lng = 0.0;

    if (shopStore.state.isSearchedWithoutAddress!) {
      lat = shopStore.state.defaultCoordinates!.latitude;
      lng = shopStore.state.defaultCoordinates!.longitude;
    } else {
      lat = double.parse(shopStore.state.placeSearchResult!.lat!);
      lng = double.parse(shopStore.state.placeSearchResult!.lng!);
    }

    if (shopStore.state.shopsList != null) {
      for (ShopModel shop in shopStore.state.shopsList!) {
        if (shop.shopLocation.latitude != null &&
            shop.shopLocation.longitude != null) {
          if ((shopStore.state.selectedRange!) >=
              calculateDistance(lat, lng, shop.shopLocation.latitude,
                  shop.shopLocation.longitude)) {
            if (shopStore.state.shopSearchFilters!.isEmpty) {
              list.add(shop);
            } else if (shopStore.state.shopSearchFilters!
                .contains(shop.shopType)) {
              list.add(shop);
            }
          }
        }
      }
    }
    return list;
  }
}
