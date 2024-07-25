import 'package:magueyapp/presentation/events/model/events_location_model.dart';

class EventModel {
  final String id;
  final String name;
  final String imageUrl;
  final EventLocationModel eventLocation;
  final DateTime? eventDate;
  final DateTime? createDate;
  final String? startTime, endTime;
  final String description;
  final String price;
  final String eventLink;
  const EventModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.eventLocation,
      required this.startTime,
      required this.endTime,
      required this.eventDate,
      required this.description,
      required this.price,
      required this.eventLink,
      required this.createDate});

  factory EventModel.fromJson(Map<String, dynamic> json, String id) {
    EventLocationModel location = EventLocationModel.fromJson(json['location']);

    String startTime = "05:00 pm";
    String endTime = "09:00 pm";

    if (json['timings'] != null) {
      if (json['timings']['start_time'] != null) {
        startTime = json['timings']['start_time'];
      }
      if (json['timings']['end_time'] != null) {
        endTime = json['timings']['end_time'];
      }
    }
    return EventModel(
      id: id.toString(),
      name: json['name'],
      imageUrl: json['image_url'],
      eventLocation: location,
      startTime: startTime,
      endTime: endTime,
      description: json['description'],
      eventDate: json['event_date'] == null
          ? null
          : DateTime.parse(json['event_date']!),
      createDate: json['event_date'] == null
          ? null
          : DateTime.parse(json['event_date']!),
      price: json['price'],
      eventLink: json['event_link'],
    );
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
