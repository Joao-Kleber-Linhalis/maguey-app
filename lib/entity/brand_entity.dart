import 'entity.dart';

class Brand extends Entity {
  String categoryId;
  String name;
  String image;
  String city;
  String state;
  String country;
  String description;

  Brand({
    required super.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.city,
    required this.state,
    required this.country,
    required this.description,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['brandId'] ?? '',
      categoryId: json['categoryId'],
      name: json['name'],
      image: json['image'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'brandId': id,
      'categoryId': categoryId,
      'name': name,
      'image': image,
      'city': city,
      'state': state,
      'country': country,
      'description': description,
    };
  }

  Brand copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? image,
    String? city,
    String? state,
    String? country,
    String? description,
  }) {
    return Brand(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      image: image ?? this.image,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      description: description ?? this.description,
    );
  }
}
