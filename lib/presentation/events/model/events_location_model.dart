class EventLocationModel {
  final String townName;
  final double? latitude;
  final double? longitude;
  final String address;
  final String state;
  final String name;

  const EventLocationModel(
      {required this.address,
      required this.latitude,
      required this.longitude,
      required this.townName,
      required this.state,
      required this.name});

  factory EventLocationModel.fromJson(Map<String, dynamic> json) {
    double? latitude;
    double? longitude;

    if (json['latitude'] != null || json['latitude'].toString().isNotEmpty) {
      latitude = double.parse(json['latitude'].toString());
    }
    if (json['longitude'] != null || json['longitude'].toString().isNotEmpty) {
      longitude = double.parse(json['longitude'].toString());
    }
    return EventLocationModel(
        address: json['address'] ?? "None",
        latitude: latitude,
        longitude: longitude,
        townName: json['city'] ?? "None",
        state: json['state'] ?? "None",
        name: json['name'] ?? "None");
  }
}

/* 
    "town_name": "String", 
    "latitude": "int",
    "longitude": "int", 
    "address": "String"

*/
