import 'entity.dart';

class EventEntity extends Entity {
  final String name;
  final String imageUrl;
  final DateTime? eventDate;
  final DateTime? createDate;
  final String? startTime, endTime;
  final String description;
  final String price;
  final String eventLink;
  final String townName;
  final double? latitude;
  final double? longitude;
  final String address;
  final String state;
  final String locationName;

  EventEntity({
    required super.id,
    required this.name,
    required this.imageUrl,
    this.startTime,
    this.endTime,
    this.eventDate,
    this.createDate,
    required this.description,
    required this.price,
    required this.eventLink,
    required this.townName,
    this.latitude,
    this.longitude,
    required this.address,
    required this.state,
    required this.locationName,
  });

  factory EventEntity.fromJson(Map<String, dynamic> json) {
    String startTime = json['timings']?['start_time'] ?? "05:00 pm";
    String endTime = json['timings']?['end_time'] ?? "09:00 pm";
    double? latitude = json['location']['latitude'] != null && json['location']['latitude'].toString().isNotEmpty
        ? double.parse(json['location']['latitude'].toString())
        : null;
    double? longitude = json['location']['longitude'] != null && json['location']['longitude'].toString().isNotEmpty
        ? double.parse(json['location']['longitude'].toString())
        : null;

    return EventEntity(
      id: json['id'] ?? '',
      name: json['name'],
      imageUrl: json['image_url'],
      startTime: startTime,
      endTime: endTime,
      description: json['description'],
      eventDate: json['event_date'] != null ? DateTime.parse(json['event_date']) : null,
      createDate: json['create_date'] != null ? DateTime.parse(json['create_date']) : null,
      price: json['price'],
      eventLink: json['event_link'],
      townName: json['location']['city'] ?? "None",
      latitude: latitude,
      longitude: longitude,
      address: json['location']['address'] ?? "None",
      state: json['location']['state'] ?? "None",
      locationName: json['location']['name'] ?? "None",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'eventDate': eventDate?.toIso8601String(),
      'createDate': createDate?.toIso8601String(),
      'price': price,
      'eventLink': eventLink,
      'townName': townName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'state': state,
      'locationName': locationName,
    };
  }

  EventEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? startTime,
    String? endTime,
    String? description,
    DateTime? eventDate,
    DateTime? createDate,
    String? price,
    String? eventLink,
    String? townName,
    double? latitude,
    double? longitude,
    String? address,
    String? state,
    String? locationName,
  }) {
    return EventEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      createDate: createDate ?? this.createDate,
      price: price ?? this.price,
      eventLink: eventLink ?? this.eventLink,
      townName: townName ?? this.townName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      state: state ?? this.state,
      locationName: locationName ?? this.locationName,
    );
  }
}
