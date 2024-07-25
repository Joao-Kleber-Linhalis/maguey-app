import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/my_bottom_sheet.dart';
import 'package:magueyapp/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/review/ui/widgets/custom_chip_tile.dart';
import 'package:magueyapp/presentation/shop/redux/reducer.dart';
import 'package:magueyapp/presentation/shop/redux/shop_actions.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/places_auto_search/google_address_search.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

void onShopFilterTap(
  BuildContext context,
  //LatLng defaultCooridantes,
  // Function(double lat, double lon) onTap
) {
  if (shopStore.state.currentLocation == null) {
    return MyToast.simple("Location Permission Required");
  }
  CustomBottomSheet.openBottomSheet(context,
      child: const ShopListViewFilterWIdget(
          // onTap: onTap
          //  defaultCoordinates: defaultCooridantes,
          ));
}

class ShopListViewFilterWIdget extends StatefulWidget {
//final Function(double lat, double lon) onTap;
//final LatLng defaultCoordinates;
  const ShopListViewFilterWIdget({
    super.key,
    // required this.defaultCoordinates
    //required this.onTap,
  });

  @override
  State<ShopListViewFilterWIdget> createState() =>
      _ShopListViewFilterWIdgetState();
}

class _ShopListViewFilterWIdgetState extends State<ShopListViewFilterWIdget> {
  bool isChecked = false;
  //double distance = 10;
  //GoogleSuggestion? placeSearchResult;
  TextEditingController shopController = TextEditingController();
  //List<String> selectedFilters = [];

  @override
  void initState() {
    shopController.text = shopStore.state.recentSearch!;
    shopStore.state.isSearchFilterApplied = false;
    // selectedFilters = shopStore.state.shopSearchFilters ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ShopState>(
      builder: (context, store) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextFormField(
            controller: shopController,
            onTap: () async {
              FocusScope.of(context).unfocus();
              store.state.placeSearchResult = await showSearch(
                context: context,
                delegate: GoogleAddressSearch(),
              );
              if (store.state.placeSearchResult != null) {
                store.state.recentSearch =
                    store.state.placeSearchResult!.address!;
                setState(() {
                  shopController.text = store.state.recentSearch!;
                });
              }
              FocusScope.of(context).unfocus();
            },
            bottomSpace: 0,
            textFieldHeight: 60.pxV(context),
            prefixConstraints:
                const BoxConstraints(maxHeight: 17, minWidth: 16),
            hintText: "Search Shop Area",
            margin: 16.paddingH(context),
            prefixIcon: Padding(
              padding: 15.paddingLeft(context),
              child: SvgPicture.asset(
                MyIcons.searchBoldIcon,
                color: MyColors.greyAFAFB7,
              ),
            ),
            prefix: 5.hSpace(context),
            hintStyle: myTextStyle.font_14w500Black.w600
                .textColor(MyColors.greyAFAFB7),
            borderRadius: 17,
          ),
          20.vSpace(context),
          Padding(
            padding: 16.paddingH(context),
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 9.pxH(context),
              runSpacing: 7.0.pxV(context),
              children: [
                ...store.state.shopsList!.map((e) => e.shopType).toSet().map(
                      (flavor) => CustomChip(
                        flavor: FlavorModel(
                            name: flavor,
                            value: 1,
                            selected:
                                store.state.shopSearchFilters!.contains(flavor)
                                    ? true
                                    : false),
                        // onChipTap: null,
                        onChipTap: (flavor) {
                          if (!shopStore.state.shopSearchFilters!
                              .contains(flavor.name)) {
                            shopStore.state.shopSearchFilters!.add(flavor.name);
                            flavor.selected = true;
                          } else {
                            shopStore.state.shopSearchFilters!
                                .remove(flavor.name);
                            flavor.selected = false;
                          }
                        },
                        padding: 10,
                        fontSize: 13,
                      ),
                    ),
              ],
            ),
          ),
          20.vSpace(context),
          Padding(
            padding: 22.paddingH(context),
            child: TextView(
              "Distance",
              style: myTextStyle.font_15w700Black,
            ),
          ),
          SizedBox(
            width: 100.percentWidth(context),
            child: Slider(
              label: store.state.selectedRange!.toInt().toString(),
              value: store.state.selectedRange!,
              min: 1,
              max: 30,
              divisions: 30,
              activeColor: MyColors.black0D0D0D,
              onChanged: (val) {
                setState(() => store.state.selectedRange = val);
              },
              thumbColor: MyColors.black0D0D0D,
            ),
          ),
          Padding(
            padding: 22.paddingH(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView("1 Miles",
                    style: myTextStyle.font_10w400Black
                      ..textColor(MyColors.grey989898)),
                TextView("30 Miles",
                    style: myTextStyle.font_10w400Black
                      ..textColor(MyColors.grey989898)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  style: const ButtonStyle(
                      // padding: MaterialStatePropertyAll(EdgeInse)
                      ),
                  onPressed: () {
                    store.dispatch(ResetSearchFiltersToDefaultAction());
                    context.pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 5),
                      Text("Reset", style: myTextStyle.font_15w700Black),
                    ],
                  )),
            ),
          ),
          32.vSpace(context),
          MyLoaderElvButton(
              padding: 16.paddingH(context),
              borderRadius: 1000,
              loader: false,
              text: "Show Results",
              textStyle: myTextStyle.font_20w800Black.copyWith(
                color: MyColors.whiteFFFFFF,
                fontSize: 18.pxV(context),
              ),
              boxShadow: [
                BoxShadow(
                  color: MyColors.black0D0D0D.withOpacity(0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
              onPressed: () {
                if (store.state.placeSearchResult != null) {
                  shopStore.dispatch(SearchShopByFiltersAction(
                    shopTypes: shopStore.state.shopSearchFilters!,
                  ));
                } else {
                  shopStore.dispatch(SearchShopWithoutAdressAction(
                      //defaultCoordinates: shopStore.state.defaultCoordinates
                      ));
                }
                Navigator.pop(context);
              }),
          SizedBox(height: 2.percentHeight(context)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    shopController.dispose();
    super.dispose();
  }
}
