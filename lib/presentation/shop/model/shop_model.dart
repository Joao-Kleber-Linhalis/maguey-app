import 'package:magueyapp/presentation/shop/model/shop_location_model.dart';

class ShopModel {
  final String id;
  final String name;
  final String imageUrl;
  final String shopType;
  final ShopLocationModel shopLocation;
  final DateTime? createDate;
  final String? openingTime, closingTime;
  final String description;
  final String contact;
  const ShopModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.shopLocation,
    required this.openingTime,
    required this.closingTime,
    required this.createDate,
    required this.description,
    required this.shopType,
    required this.contact,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json, String id) {
    ShopLocationModel location = ShopLocationModel.fromJson(json['location']);

    String? openingTime;
    String? closingTime;
    if (json['timings'] != null) {
      if (json['timings']['opening_time'] != null &&
          json['timings']['opening_time'].toString().isNotEmpty) {
        openingTime = json['timings']['opening_time'];
      }
      if (json['timings']['closing_time'] != null &&
          json['timings']['closing_time'].toString().isNotEmpty) {
        closingTime = json['timings']['closing_time'];
      }
    }
    return ShopModel(
      id: id.toString(),
      name: json['name'],
      imageUrl: json['image_url'],
      shopLocation: location,
      openingTime: openingTime,
      closingTime: closingTime,
      description: json['description'] ?? "",
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date']!),
      shopType: json['business_type'],
      contact: json['contact'],
    );
  }

  bool get isRetail => shopType.toLowerCase() == "retail";

  Map<String, dynamic> toJson() {
    return {};
  }
}



/*

    "id": "String", 
    "name": "String", 
    "image_url": "String",
    "location": {
        "town_name": "String", 
        "latitude": "int",
        "longitude": "int", 
        "address": "String"
    }, 
    "timings": {
        "opening_time": "DateTime",
        "closing_time": "DateTime"
    }, 
    "description": "String", 
    "create_date": "DateTime", 
    "products": [
        "Product Id (int)"
    ]

 */
