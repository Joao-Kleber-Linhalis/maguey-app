import 'entity.dart';

class EventSuggestion extends Entity {
  String title;
  String date;
  String address;
  String townState;
  String description;

  EventSuggestion({
    required super.id,
    required this.title,
    required this.date,
    required this.address,
    required this.townState,
    required this.description,
  });

  factory EventSuggestion.fromJson(Map<String, dynamic> json) {
    return EventSuggestion(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      address: json['address'] ?? '',
      townState: json['townState'] ?? '',
      description: json['description'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'address': address,
      'townState': townState,
      'description': description,
    };
  }

  EventSuggestion copyWith({
    String? id,
    String? title,
    String? date,
    String? address,
    String? townState,
    String? description,
  }) {
    return EventSuggestion(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      address: address ?? this.address,
      townState: townState ?? this.townState,
      description: description ?? this.description,
    );
  }
}
