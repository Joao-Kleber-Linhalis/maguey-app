import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Duration animationDuration = const Duration(milliseconds: 500);
  final Curve curve = Curves.fastEaseInToSlowEaseOut;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    LatLng currentLocation = LatLng(32.7496694, -117.1924533);
    double _latitude = currentLocation.latitude;
    double _longitude = currentLocation.longitude;
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: _controller.complete,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 12.0,
        ),
        mapType: MapType.satellite,
        markers: {
          const Marker(
            markerId: MarkerId('32.7496694-117.184564_1'),
            position: LatLng(32.7496694, -117.184564),
          ),
          const Marker(
            markerId: MarkerId('32.7496694-117.1843435_2'),
            position: LatLng(32.7496694, -117.1843435),
          ),
          const Marker(
            markerId: MarkerId('32.7496694-117.1702424_3'),
            position: LatLng(32.7496694, -117.1702424),
          ),
        },
        onCameraMove: (CameraPosition position) {
          setState(() {
            currentLocation = position.target;
            _latitude = currentLocation.latitude;
            _longitude = currentLocation.longitude;
          });
        },
      ),
    );
  }
}
