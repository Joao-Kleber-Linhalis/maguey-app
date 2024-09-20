import 'entity.dart';

class Product extends Entity {
  String productToScrapUrl;
  String brandUrl;
  String brandName;
  String brandImageUrl;
  String productName;
  String productImageUrl;
  String productNewImageName;
  String productDescription;
  String categoryId;
  String cost;
  String brandId;
  String mezcalero;
  String maguey;
  String agave;
  String fermentation;
  String milling;
  String distillation;
  String style;
  String state;
  String town;
  String abv;
  String website;
  String age;
  String year;
  List<dynamic> listFlavors;

  Product({
    required super.id,
    required this.productToScrapUrl,
    required this.brandUrl,
    required this.brandName,
    required this.brandImageUrl,
    required this.productName,
    required this.productImageUrl,
    required this.productNewImageName,
    required this.productDescription,
    required this.categoryId,
    required this.cost,
    required this.brandId,
    required this.mezcalero,
    required this.maguey,
    required this.agave,
    required this.fermentation,
    required this.milling,
    required this.distillation,
    required this.style,
    required this.state,
    required this.town,
    required this.abv,
    required this.website,
    required this.age,
    required this.year,
    required this.listFlavors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      productToScrapUrl: json['productToScrapUrl'] ?? '',
      brandUrl: json['brandUrl'] ?? '',
      brandName: json['brandName'] ?? '',
      brandImageUrl: json['brandImageUrl'] ?? '',
      productName: json['productName'] ?? '',
      productImageUrl: json['productImageUrl'] ?? '',
      productNewImageName: json['productNewImageName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      categoryId: json['categoryId'] ?? '',
      cost: json['cost'] ?? '',
      brandId: json['brandId'] ?? '',
      mezcalero: json['mezcalero'] ?? '',
      maguey: json['maguey'] ?? '',
      agave: json['agave'] ?? '',
      fermentation: json['fermentation'] ?? '',
      milling: json['milling'] ?? '',
      distillation: json['distillation'] ?? '',
      style: json['style'] ?? '',
      state: json['state'] ?? '',
      town: json['town'] ?? '',
      abv: json['abv'] ?? '',
      website: json['website'] ?? '',
      age: json['age'] ?? '',
      year: json['year'] ?? '',
      listFlavors: json['listFlavors'] is List
          ? json['listFlavors']
          : json['listFlavors'] != null && json['listFlavors'] is String
              ? json['listFlavors'].split(',').map((e) => e.trim()).toList()
              : [], // Ensure it's always a list
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productToScrapUrl': productToScrapUrl,
      'brandUrl': brandUrl,
      'brandName': brandName,
      'brandImageUrl': brandImageUrl,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'productNewImageName': productNewImageName,
      'productDescription': productDescription,
      'categoryId': categoryId,
      'cost': cost,
      'brandId': brandId,
      'mezcalero': mezcalero,
      'maguey': maguey,
      'agave': agave,
      'fermentation': fermentation,
      'milling': milling,
      'distillation': distillation,
      'style': style,
      'state': state,
      'town': town,
      'abv': abv,
      'website': website,
      'age': age,
      'year': year,
      'listFlavors': listFlavors,
    };
  }

  Product copyWith({
    String? id,
    String? productToScrapUrl,
    String? brandUrl,
    String? brandName,
    String? brandImageUrl,
    String? productName,
    String? productImageUrl,
    String? productNewImageName,
    String? productDescription,
    String? categoryId,
    String? cost,
    String? brandId,
    String? mezcalero,
    String? maguey,
    String? agave,
    String? grind,
    String? fermentation,
    String? milling,
    String? distillation,
    String? style,
    String? state,
    String? town,
    String? abv,
    String? website,
    String? age,
    String? year,
    List<String>? listFlavors,
  }) {
    return Product(
      id: id ?? this.id,
      productToScrapUrl: productToScrapUrl ?? this.productToScrapUrl,
      brandUrl: brandUrl ?? this.brandUrl,
      brandName: brandName ?? this.brandName,
      brandImageUrl: brandImageUrl ?? this.brandImageUrl,
      productName: productName ?? this.productName,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      productNewImageName: productNewImageName ?? this.productNewImageName,
      productDescription: productDescription ?? this.productDescription,
      categoryId: categoryId ?? this.categoryId,
      cost: cost ?? this.cost,
      brandId: brandId ?? this.brandId,
      mezcalero: mezcalero ?? this.mezcalero,
      maguey: maguey ?? this.maguey,
      agave: agave ?? this.agave,
      fermentation: fermentation ?? this.fermentation,
      milling: milling ?? this.milling,
      distillation: distillation ?? this.distillation,
      style: style ?? this.style,
      state: state ?? this.state,
      town: town ?? this.town,
      abv: abv ?? this.abv,
      website: website ?? this.website,
      age: age ?? this.age,
      year: year ?? this.year,
      listFlavors: listFlavors ?? this.listFlavors,
    );
  }
}
