import 'entity.dart';

class ShopEntity extends Entity {
  final String name;
  final String imageUrl;
  final String shopType;
  final String townName;
  final double? latitude;
  final double? longitude;
  final String address;
  final DateTime? createDate;
  final String? openingTime, closingTime;
  final String description;
  final String contact;

  ShopEntity({
    required super.id,
    required this.name,
    required this.imageUrl,
    required this.shopType,
    required this.townName,
    this.latitude,
    this.longitude,
    required this.address,
    this.openingTime,
    this.closingTime,
    this.createDate,
    required this.description,
    required this.contact,
  });

  factory ShopEntity.fromJson(Map<String, dynamic> json) {
    double? latitude = json['location']['latitude'] != null && json['location']['latitude'].toString().isNotEmpty
        ? double.parse(json['location']['latitude'].toString())
        : null;
    double? longitude = json['location']['longitude'] != null && json['location']['longitude'].toString().isNotEmpty
        ? double.parse(json['location']['longitude'].toString())
        : null;

    return ShopEntity(
      id: json['id'] ?? '',
      name: json['name'],
      imageUrl: json['image_url'],
      shopType: json['business_type'],
      townName: json['location']['city'] ?? "None",
      latitude: latitude,
      longitude: longitude,
      address: json['location']['address'] ?? "None",
      openingTime: json['timings']?['opening_time'],
      closingTime: json['timings']?['closing_time'],
      description: json['description'] ?? "",
      createDate: json['create_date'] != null ? DateTime.parse(json['create_date']) : null,
      contact: json['contact'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'shopType': shopType,
      'townName': townName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'description': description,
      'createDate': createDate?.toIso8601String(),
      'contact': contact,
    };
  }

  ShopEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? shopType,
    String? townName,
    double? latitude,
    double? longitude,
    String? address,
    String? openingTime,
    String? closingTime,
    DateTime? createDate,
    String? description,
    String? contact,
  }) {
    return ShopEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      shopType: shopType ?? this.shopType,
      townName: townName ?? this.townName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      createDate: createDate ?? this.createDate,
      description: description ?? this.description,
      contact: contact ?? this.contact,
    );
  }
}
