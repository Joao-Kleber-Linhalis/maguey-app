import 'package:magueyapp/entity/entity.dart';

class ProductSuggestion extends Entity {
  String name;
  String brand;
  String description;

  ProductSuggestion({
    required this.name,
    required this.brand,
    required this.description,
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'description': description,
    };
  }

  factory ProductSuggestion.fromJson(Map<String, dynamic> json) {
    return ProductSuggestion(
      id: json['id'] ?? '',
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
    );
  }
  ProductSuggestion copyWith({
    String? name,
    String? brand,
    String? description,
    required String id,
  }) {
    return ProductSuggestion(
      id: id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      description: description ?? this.description,
    );
  }
}
