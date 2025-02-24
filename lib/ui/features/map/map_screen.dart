import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/my_map_themes.dart';
import 'package:provider/provider.dart';

import '../../../provider/dashboard_provider.dart';

class LoadMap extends StatelessWidget {
  const LoadMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: _fetchLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.whiteFFFFFF,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          return MapPage(
            latitude: snapshot.data?.latitude ?? 33.99788550112016,
            longitude: snapshot.data?.longitude ?? -118.2565948739648,
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: MyColors.whiteFFFFFF,
          ),
        );
      },
    );
  }
}

Future<bool> _requestPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  return permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;
}

Future<Position> _getCurrentLocation() async {
  if (await _requestPermission()) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
  throw Exception('Location permission not granted');
}

Future<Position> _fetchLocation() async {
  try {
    Position position = await _getCurrentLocation();
    return position;
  } catch (e) {
    throw Exception('Unable to fetch location: $e');
  }
}

class MapPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapPage({super.key, required this.latitude, required this.longitude});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoadingMap = true;
  late DashboardProvider dashboardProvider;
  List<ShopEventEntity> shopEventList = [];
  List<ShopEventEntity> filterShopEventList = [];
  ShopEventEntity currentShopEvent = ShopEventEntity(
    latitude: 0,
    longitude: 0,
    link: "",
    name: "",
    townName: "",
    id: "",
    imageUrl: "",
    description: "",
    createDate: DateTime.now(),
    address: "",
    type: "",
  );

  String _mapStyle = '';
  double latitude = 0.0;
  double longitude = 0.0;
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(widget.latitude, widget.longitude);
    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    shopEventList = dashboardProvider.shopEventList;
    filterShopEventList = shopEventList;
    _loadMapStyle();
    populateListMarkersList();
    searchController.addListener(_filterEvents);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoadingMap = false;
      });
    });
  }

  void _filterEvents() {
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      // Atualiza a lista de eventos filtrados
      filterShopEventList = shopEventList.where((event) {
        return event.name.toLowerCase().contains(searchTerm) ||
            event.townName.toLowerCase().contains(searchTerm) ||
            event.address.toLowerCase().contains(searchTerm);
      }).toList();

      // Atualiza os marcadores com base na lista filtrada
      markers.clear(); // Limpa os marcadores anteriores
      populateListMarkersList(); // Popula os novos marcadores
    });
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString(MyMapThemes.mapGreyTheme);
    setState(() {
      _mapStyle = style;
    });
  }

  Set<Marker> markers = {};
  void populateListMarkersList() async {
    if (filterShopEventList.isEmpty) return;
    String _iconImage = MyIcons.markerIconWithouCenter;
    final bitmapIcon = await BitmapDescriptor.asset(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(50, 50)),
        _iconImage);
    currentShopEvent = filterShopEventList[0];
    for (int i = 0; i < filterShopEventList.length; i++) {
      ShopEventEntity shopEvent = filterShopEventList[i];
      markers.add(
        Marker(
          markerId: MarkerId('${shopEvent.latitude}-${shopEvent.longitude}_$i'),
          position: LatLng(shopEvent.latitude!, shopEvent.longitude!),
          onTap: () {
            currentShopEvent = shopEvent;
          },
          icon: bitmapIcon,
        ),
      );
    }
  }

  //Para testes mockados
  // void populateListMarkersList() async {
  //   // Lista de eventos mockados para teste
  //   List<ShopEventEntity> mockShopEventList = [
  //     ShopEventEntity(
  //       id: '1',
  //       name: 'Evento São Paulo',
  //       imageUrl: 'https://example.com/image1.jpg',
  //       createDate: DateTime.now(),
  //       openingTime: '09:00',
  //       closingTime: '18:00',
  //       description: 'Evento de teste em São Paulo',
  //       townName: 'São Paulo',
  //       latitude: -23.550520,
  //       longitude: -46.633308,
  //       address: 'Av. Paulista, 1000',
  //       contact: '(11) 1234-5678',
  //       link: 'https://example.com/sp-event',
  //       type: 'Festival',
  //     ),
  //     ShopEventEntity(
  //       id: '2',
  //       name: 'Evento Rio de Janeiro',
  //       imageUrl: 'https://example.com/image2.jpg',
  //       createDate: DateTime.now(),
  //       openingTime: '10:00',
  //       closingTime: '20:00',
  //       description: 'Evento de teste no Rio de Janeiro',
  //       townName: 'Rio de Janeiro',
  //       latitude: -22.906847,
  //       longitude: -43.172896,
  //       address: 'Rua das Flores, 200',
  //       contact: '(21) 9876-5432',
  //       link: 'https://example.com/rj-event',
  //       type: 'Exposição',
  //     ),
  //     ShopEventEntity(
  //       id: '3',
  //       name: 'Evento Brasília',
  //       imageUrl: 'https://example.com/image3.jpg',
  //       createDate: DateTime.now(),
  //       openingTime: '08:00',
  //       closingTime: '17:00',
  //       description: 'Evento de teste em Brasília',
  //       townName: 'Brasília',
  //       latitude: -15.826691,
  //       longitude: -47.921820,
  //       address: 'Praça dos Três Poderes, 300',
  //       contact: '(61) 3456-7890',
  //       link: 'https://example.com/bsb-event',
  //       type: 'Conferência',
  //     ),
  //     ShopEventEntity(
  //       id: '4',
  //       name: 'Evento Porto Alegre',
  //       imageUrl: 'https://example.com/image4.jpg',
  //       createDate: DateTime.now(),
  //       openingTime: '07:00',
  //       closingTime: '19:00',
  //       description: 'Evento de teste em Porto Alegre',
  //       townName: 'Porto Alegre',
  //       latitude: -30.034647,
  //       longitude: -51.217658,
  //       address: 'Av. Borges de Medeiros, 1500',
  //       contact: '(51) 4567-1234',
  //       link: 'https://example.com/poa-event',
  //       type: 'Feira',
  //     ),
  //   ];

  //   if (mockShopEventList.isEmpty) return;

  //   currentShopEvent = mockShopEventList[0];
  //   String _iconImage = MyIcons.markerIconWithouCenter;
  //   final bitmapIcon = await BitmapDescriptor.asset(
  //       ImageConfiguration(devicePixelRatio: 2.5, size: Size(50, 50)),
  //       _iconImage);
  //   for (int i = 0; i < mockShopEventList.length; i++) {
  //     ShopEventEntity shopEvent = mockShopEventList[i];
  //     markers.add(
  //       Marker(
  //         markerId: MarkerId('${shopEvent.latitude}-${shopEvent.longitude}_$i'),
  //         position: LatLng(shopEvent.latitude!, shopEvent.longitude!),
  //         onTap: () {
  //           currentShopEvent = shopEvent;
  //         },
  //         icon: bitmapIcon,
  //       ),
  //     );
  //   }

  //   print(mockShopEventList);
  // }

  final Duration animationDuration = const Duration(milliseconds: 500);
  final Curve curve = Curves.fastEaseInToSlowEaseOut;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      body: isLoadingMap
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.whiteFFFFFF,
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  style: _mapStyle,
                  onMapCreated: _controller.complete,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 12.0,
                  ),
                  mapType: MapType.normal,
                  markers: markers,
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      currentLocation = position.target;
                      latitude = currentLocation.latitude;
                      longitude = currentLocation.longitude;
                    });
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: MyColors.black2B2B2B,
                        ),
                        hintText: 'Search Restaurants, Bars, Stores near you',
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: MyColors.black2B2B2B),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (currentShopEvent.imageUrl.isNotEmpty)
                            Container(
                              height: 88,
                              width: 88,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    currentShopEvent.imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentShopEvent.type.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFFFB5944),
                                    fontSize: 13,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  currentShopEvent.name,
                                  style: const TextStyle(
                                    color: Color(0xFF908C00),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                if (currentShopEvent.type == 'event')
                                  Text(
                                    DateFormat('MMMM dd yyyy')
                                        .format(currentShopEvent.createDate!),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                Text(
                                  currentShopEvent.address,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
