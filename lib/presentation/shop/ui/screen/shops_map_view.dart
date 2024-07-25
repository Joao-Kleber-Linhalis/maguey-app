import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magueyapp/common/functions/distance_calculate.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/redux/reducer.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shops_map_searchbar.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class AllShopsMapScreen extends StatefulWidget {
  static const String route = "map_screen";
  final Function()? onListTap;
  final Function(ShopModel)? onMarkerTap;
  const AllShopsMapScreen({
    super.key,
    this.onListTap,
    this.onMarkerTap,
  });

  @override
  State<AllShopsMapScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<AllShopsMapScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  // final LatLng _pGooglePlex =
  //     const LatLng(24.872796580988535, 67.17892073877947);
  final Completer<GoogleMapController> _controller = Completer();
  String mapTheme = "";
  //LatLng? deafultCoordinates;
  //double? zoom = 11.0;

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString(MyMapThemes.mapDefaultTheme)
        .then((value) => mapTheme = value);
    WidgetsBinding.instance.addPostFrameCallback((_) => _generateMarkersShop());

    // _generateMarkers();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AllShopsMapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  bool loading = true;

  BitmapDescriptor? marketIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loading
          ? const Center(child: CupertinoActivityIndicator())
          : StoreBuilder<ShopState>(builder: (context, shopStore) {
              double lat = 0, lng = 0;
              if (shopStore.state.isSearchFilterApplied!) {
                lat = double.parse(shopStore.state.placeSearchResult!.lat!);
                lng = double.parse(shopStore.state.placeSearchResult!.lng!);
                _goToPositionShop(lat, lng);
                //  shopStore.state.isSearchFilterApplied = false;
              } else if (shopStore.state.isSearchedWithoutAddress!) {
                lat = shopStore.state.defaultCoordinates!.latitude;
                lng = shopStore.state.defaultCoordinates!.longitude;
                _goToPositionShop(shopStore.state.defaultCoordinates!.latitude,
                    shopStore.state.defaultCoordinates!.longitude);
                // shopStore.state.isSearchedWithoutAddress = false;
              } else if (shopStore.state.resetSearchFilterApplied!) {
                lat = shopStore.state.defaultCoordinates!.latitude;
                lng = shopStore.state.defaultCoordinates!.longitude;
                _goToPositionShop(shopStore.state.defaultCoordinates!.latitude,
                    shopStore.state.defaultCoordinates!.longitude);
              }

              return Stack(
                children: [
                  SizedBox(
                    height: 100.percentHeight(context),
                    width: 100.percentWidth(context),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _targetShop(),
                        zoom: 11.0,
                      ),
                      zoomControlsEnabled: false,
                      markers: shopStore.state.isSearchFilterApplied! ||
                              shopStore.state.isSearchedWithoutAddress!
                          ? _filteredMarkersShop(lat, lng)
                          : _markersShop(),
                      onMapCreated: (controller) async {
                        await controller.setMapStyle(mapTheme);
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  ShopsMapSearchbar(
                    onListTap: widget.onListTap,
                    // defaultCoordinates: deafultCoordinates!,
                    //showResults: _goToPosition,
                  ),
                ],
              );
            }),
    );
  }

  LatLng _targetShop() {
    if (shopStore.state.shopsList != null) {
      for (ShopModel shop in shopStore.state.shopsList!) {
        if (shop.shopLocation.latitude != null &&
            shop.shopLocation.longitude != null) {
          // deafultCoordinates =
          shopStore.state.defaultCoordinates =
              LatLng(shop.shopLocation.latitude!, shop.shopLocation.longitude!);
          return LatLng(
            shop.shopLocation.latitude!,
            shop.shopLocation.longitude!,
          );
        }
      }
    }
    return const LatLng(23.872796580988535, 67.17892073877947);
  }

  Set<Marker> _markersShop() {
    Set<Marker> markers = {};
    if (shopStore.state.shopsList != null) {
      for (ShopModel shop in shopStore.state.shopsList!) {
        if (shop.shopLocation.latitude != null &&
            shop.shopLocation.longitude != null) {
          markers.add(
            Marker(
              markerId: MarkerId(shop.id),
              position: LatLng(
                shop.shopLocation.latitude!,
                shop.shopLocation.longitude!,
              ),
              onTap: () {
                if (widget.onMarkerTap != null) widget.onMarkerTap!(shop);
              },
              icon: marketIcon ?? BitmapDescriptor.defaultMarker,
            ),
          );
        }
      }
    }
    return markers;
  }

  Set<Marker> _filteredMarkersShop(double lat, double lng) {
    Set<Marker> markers = {};
    if (shopStore.state.shopsList != null) {
      for (ShopModel shop in shopStore.state.shopsList!) {
        if (shop.shopLocation.latitude != null &&
            shop.shopLocation.longitude != null) {
          if ((shopStore.state.selectedRange!) >=
              calculateDistance(lat, lng, shop.shopLocation.latitude,
                  shop.shopLocation.longitude)) {
            if (shopStore.state.shopSearchFilters!.isEmpty) {
              markers.add(
                Marker(
                  markerId: MarkerId(shop.id),
                  position: LatLng(
                    shop.shopLocation.latitude!,
                    shop.shopLocation.longitude!,
                  ),
                  onTap: () {
                    if (widget.onMarkerTap != null) widget.onMarkerTap!(shop);
                  },
                  icon: marketIcon ?? BitmapDescriptor.defaultMarker,
                ),
              );
            } else if (shopStore.state.shopSearchFilters!
                .contains(shop.shopType)) {
              markers.add(
                Marker(
                  markerId: MarkerId(shop.id),
                  position: LatLng(
                    shop.shopLocation.latitude!,
                    shop.shopLocation.longitude!,
                  ),
                  onTap: () {
                    if (widget.onMarkerTap != null) widget.onMarkerTap!(shop);
                  },
                  icon: marketIcon ?? BitmapDescriptor.defaultMarker,
                ),
              );
            }
          }
        }
      }
    }
    return markers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _generateMarkersShop() async {
    loading = true;

    Uint8List markerIcon = await getBytesFromAsset(MyIcons.markerIcon, 150);

    marketIcon = BitmapDescriptor.fromBytes(markerIcon);

    loading = false;
    if (mounted) setState(() {});
  }
  // _generateMarkersShop() async {
  //   loading = true;

  //   marketIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     MyIcons.markerIcon,
  //   );

  //   loading = false;
  //   if (context.mounted) setState(() {});
  // }

  void _goToPositionShop(double lat, double lon) {
    double zoomLevel = 11.0;
    double selectedRangeInMiles = shopStore.state.selectedRange!;

    if (selectedRangeInMiles <= 10) {
      zoomLevel = 12;
    } else if (selectedRangeInMiles > 10 && selectedRangeInMiles <= 20) {
      zoomLevel = 11.0;
    } else if (selectedRangeInMiles > 20 && selectedRangeInMiles <= 30) {
      zoomLevel = 10.0;
    }

    _controller.future.then((controller) => controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(lat, lon),
              zoom: zoomLevel,
            ),
          ),
        ));
  }
}


/* 

  Container(
              margin: 24.paddingH(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.greyFDFDFD,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.percentWidth(context),
                    child: MyTextFormField(
                      // borderRadius: 100.percentWidth(context),
                      hintText: "Search Here",
                      filledColor: MyColors.greyFDFDFD,
                      hintStyle: myTextStyle.font_12w500Black
                          .textColor(MyColors.black0D0D0D.withOpacity(0.6)),
                    ),
                  ),
                  const Icon(Icons.search)
                ],
              ),
            ),
*/
