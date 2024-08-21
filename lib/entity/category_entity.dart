import 'entity.dart';

class Category extends Entity {
  String name;
  String shortDescription;

  Category({
    required super.id,
    required this.name,
    required this.shortDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      shortDescription: json['shortDescription'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
    };
  }

  Category copyWith({String? id, String? name}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription,
    );
  }
}
