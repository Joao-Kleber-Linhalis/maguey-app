import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magueyapp/common/functions/distance_calculate.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/redux/reducer.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_map_searchbar.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class AllEventsMapScreen extends StatefulWidget {
  static const String route = "map_screen";
  final Function()? onListTap;
  final Function(EventModel)? onMarkerTap;
  const AllEventsMapScreen({
    super.key,
    this.onListTap,
    this.onMarkerTap,
  });

  @override
  State<AllEventsMapScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<AllEventsMapScreen> {
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _generateMarkersEvent());

    // _generateMarkers();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AllEventsMapScreen oldWidget) {
    //setState(() {});
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
          : StoreBuilder<EventState>(
              builder: (context, eventStore) {
                double lat = 0, lng = 0;
                if (eventStore.state.isSearchFilterApplied!) {
                  lat = double.parse(eventStore.state.placeSearchResult!.lat!);
                  lng = double.parse(eventStore.state.placeSearchResult!.lng!);
                  _goToPositionEvent(lat, lng);
                  // eventStore.state.isSearchFilterApplied = false;
                } else if (eventStore.state.isSearchedWithoutAddress!) {
                  lat = eventStore.state.defaultCoordinates!.latitude;
                  lng = eventStore.state.defaultCoordinates!.longitude;
                  _goToPositionEvent(
                      eventStore.state.defaultCoordinates!.latitude,
                      eventStore.state.defaultCoordinates!.longitude);
                  //eventStore.state.isSearchedWithoutAddress = false;
                } else if (eventStore.state.resetSearchFilterApplied!) {
                  lat = eventStore.state.defaultCoordinates!.latitude;
                  lng = eventStore.state.defaultCoordinates!.longitude;
                  _goToPositionEvent(
                      eventStore.state.defaultCoordinates!.latitude,
                      eventStore.state.defaultCoordinates!.longitude);
                }
                return Stack(
                  children: [
                    SizedBox(
                      height: 100.percentHeight(context),
                      width: 100.percentWidth(context),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _targetEvent(),
                          zoom: 11.0,
                        ),
                        zoomControlsEnabled: false,
                        markers: eventStore.state.isSearchFilterApplied! ||
                                eventStore.state.isSearchedWithoutAddress!
                            ? _filteredMarkersEvent(lat, lng)
                            : _markersEvent(),
                        onMapCreated: (controller) async {
                          await controller.setMapStyle(mapTheme);
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    EventsMapSearchbar(onListTap: widget.onListTap),
                  ],
                );
              },
            ),
    );
  }

  LatLng _targetEvent() {
    if (eventStore.state.eventList != null) {
      for (EventModel event in eventStore.state.eventList!) {
        if (event.eventLocation.latitude != null &&
            event.eventLocation.longitude != null) {
          eventStore.state.defaultCoordinates = LatLng(
              event.eventLocation.latitude!, event.eventLocation.longitude!);
          return LatLng(
            event.eventLocation.latitude!,
            event.eventLocation.longitude!,
          );
        }
      }
    }
    return const LatLng(23.872796580988535, 67.17892073877947);
  }

  Set<Marker> _markersEvent() {
    Set<Marker> markers = {};
    if (eventStore.state.eventList != null) {
      for (EventModel event in eventStore.state.eventList!) {
        if (event.eventLocation.latitude != null &&
            event.eventLocation.longitude != null) {
          markers.add(
            Marker(
              markerId: MarkerId(event.id),
              position: LatLng(
                event.eventLocation.latitude!,
                event.eventLocation.longitude!,
              ),
              onTap: () {
                if (widget.onMarkerTap != null) widget.onMarkerTap!(event);
              },
              icon: marketIcon ?? BitmapDescriptor.defaultMarker,
            ),
          );
        }
      }
    }
    return markers;
  }

  Set<Marker> _filteredMarkersEvent(double lat, double lng) {
    Set<Marker> markers = {};
    if (eventStore.state.eventList != null) {
      for (EventModel event in eventStore.state.eventList!) {
        if (event.eventLocation.latitude != null &&
            event.eventLocation.longitude != null) {
          if ((eventStore.state.selectedRange!) >=
              calculateDistance(lat, lng, event.eventLocation.latitude,
                  event.eventLocation.longitude)) {
            //   if (eventStore.state.eventSearchFilters!.isEmpty) {
            markers.add(
              Marker(
                markerId: MarkerId(event.id),
                position: LatLng(
                  event.eventLocation.latitude!,
                  event.eventLocation.longitude!,
                ),
                onTap: () {
                  if (widget.onMarkerTap != null) widget.onMarkerTap!(event);
                },
                icon: marketIcon ?? BitmapDescriptor.defaultMarker,
              ),
            );
            //   }
            // else if (eventStore.state.eventSearchFilters!
            //     .contains(event.eventType)) {
            //   markers.add(
            //     Marker(
            //       markerId: MarkerId(event.id),
            //       position: LatLng(
            //         event.eventLocation.latitude!,
            //         event.eventLocation.longitude!,
            //       ),
            //       onTap: () {
            //         if (widget.onMarkerTap != null) widget.onMarkerTap!(event);
            //       },
            //       icon: marketIcon ?? BitmapDescriptor.defaultMarker,
            //     ),
            //   );
            // }
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

  _generateMarkersEvent() async {
    loading = true;

    Uint8List markerIcon = await getBytesFromAsset(MyIcons.markerIcon, 150);

    marketIcon = BitmapDescriptor.fromBytes(markerIcon);

    loading = false;
    if (context.mounted) setState(() {});
  }

  // _generateMarkersEvent() async {
  //   loading = true;

  //   marketIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     MyIcons.markerIcon,
  //   );

  //   loading = false;
  //   if (context.mounted) setState(() {});
  // }

  void _goToPositionEvent(double lat, double lon) {
    double zoomLevel = 11.0;
    double selectedRangeInMiles = eventStore.state.selectedRange!;

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

  // void _goToPositionEvent(double lat, double lon) {
  //   eventStore.state.zoom = 11 + (10 - (eventStore.state.selectedRange! / 3));
  //   _controller.future.then((controller) => controller.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(lat, lon),
  //             zoom: eventStore.state.zoom!,
  //           ),
  //         ),
  //       ));
  // }
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
