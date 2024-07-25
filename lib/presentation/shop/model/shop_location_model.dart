class ShopLocationModel {
  final String townName;
  final double? latitude;
  final double? longitude;
  final String address;

  const ShopLocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.townName,
  });

  factory ShopLocationModel.fromJson(Map<String, dynamic> json) {
    double? latitude;
    double? longitude;

    if (json['latitude'] != null || json['latitude'].toString().isNotEmpty) {
      latitude = double.parse(json['latitude'].toString());
    }
    if (json['longitude'] != null || json['longitude'].toString().isNotEmpty) {
      longitude = double.parse(json['longitude'].toString());
    }
    return ShopLocationModel(
      address: json['address'] ?? "None",
      latitude: latitude,
      longitude: longitude,
      townName: json['city'] ?? "None",
    );
  }
}

/* 
    "town_name": "String", 
    "latitude": "int",
    "longitude": "int", 
    "address": "String"

*/
