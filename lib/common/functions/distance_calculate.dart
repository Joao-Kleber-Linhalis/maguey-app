import 'package:geolocator/geolocator.dart';

double calculateDistance(double lat1, double lon1, lat2, lon2) {
  double distanceInMeters = Geolocator.distanceBetween(
    lat1,
    lon1,
    lat2,
    lon2,
  );
  // Convert meters to miles
  double distanceInMiles = distanceInMeters / 1609.34;
  return distanceInMiles;
}

// double calculateDistance(lat1, lon1, lat2, lon2) {
//   var distanceInMeters = Geolocator.distanceBetween(
//     lat1,
//     lon1,
//     lat2,
//     lon2,
//   );
//   return distanceInMeters;
// }
