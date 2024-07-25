import 'dart:ui';

import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/presentation/product/model/product_info_model.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class ProductModel {
  final String id;
  final String categoryId, categoryName;
  final String? subCategoryId, subCategoryName;
  final String imageUrl, name, manufacturerName, description;
  final Color color;
  final String price;
  final List<ProductInfo> information;
  final List<FlavorModel> flavors;
  final List<ProductReview> reviews;
  final List<FlavorModel> topFlavors;
  final double rating;
  ProductReview? myReview;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    required this.color,
    required this.name,
    required this.description,
    required this.manufacturerName,
    required this.price,
    required this.information,
    required this.flavors,
    required this.reviews,
    required this.topFlavors,
    required this.rating,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.myReview,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
    String id, {
    List<FlavorModel> flavors = const [],
  }) {
    String color1Code = "0xffe4d9d0";
    // String color1Code = json['color'] ;
    // if (json['color'] != null && json['color'] != "") {
    //   if (color1Code[0] == "#") {
    //     color1Code = "0xff${color1Code.substring(1)}";
    //   } else {
    //     color1Code = "0xff${json['color']}";
    //   }
    // }

    List<ProductReview> productReviews = [];
    ProductReview? myReview;
    if (json['reviews'] != null) {
      productReviews = _getAllReviews(json['reviews'], id);
      myReview = _getMyReview(productReviews);
    }

    List<FlavorModel> topFlavors = _getTopFlavors(productReviews);

    //String imageUrl = getDriveViewableLink(json['image_url']);
    String imageUrl = json['image_url'];
    return ProductModel(
      id: id,
      categoryId: json['category']['id'].toString(),
      categoryName: json['category']['name'],
      imageUrl: imageUrl, // json['image_url'],
      color: Color(int.parse(color1Code)),
      name: json['name'],
      description: json['description'],
      manufacturerName: json['manufacturer']['name'],
      price: json['price'],
      information: _getProductInfoList(json['information'] ?? {}),
      reviews: productReviews,
      topFlavors: topFlavors,
      rating: _getRating(productReviews),
      subCategoryId:
          json['sub-category'] == null ? null : json['sub-category']['id'],
      subCategoryName:
          json['sub-category'] == null ? null : json['sub-category']['name'],
      flavors: _getFlavors(topFlavors, flavors),
      myReview: myReview,
    );
  }

  static List<FlavorModel> _getFlavors(
    List<FlavorModel> topFlavors,
    List<FlavorModel> flavors,
  ) {
    List<FlavorModel> topFlavorsSorted = List.from(topFlavors)
      ..sort((f1, f2) => f1.name.compareTo(f2.name));

    List<FlavorModel> allFlavorsSorted = List.from(flavors)
      ..sort((f1, f2) => f1.name.compareTo(f2.name));
    Map<String, FlavorModel> freqMap = {};

    for (FlavorModel flavor in [...topFlavorsSorted, ...allFlavorsSorted]) {
      String key = flavor.name.toLowerCase();
      if (freqMap[key] == null) {
        freqMap[key] = flavor;
      }
    }
    List<FlavorModel> result = freqMap.values.toList()
      ..sort((f1, f2) => f2.value.compareTo(f1.value));

    return result;
  }

  static List<ProductInfo> _getProductInfoList(List json) {
    if (json.isEmpty) return [];
    return json.map((info) => ProductInfo.fromJson(info)).toList();
  }

  static List<FlavorModel> _getTopFlavors(List<ProductReview> productReviews) {
    List<FlavorModel> tempTopFlavors = [];
    Map<String, dynamic> freqMap = {};
    List<String> flavors = [];

    for (ProductReview review in productReviews) {
      flavors = [...flavors, ...review.flavors];
    }

    for (String flavor in flavors) {
      if (freqMap[flavor] == null) {
        freqMap[flavor] = 1;
      } else {
        freqMap[flavor] = freqMap[flavor] + 1;
      }
    }

    freqMap.forEach((key, value) {
      tempTopFlavors.add(FlavorModel(name: key, value: value));
    });

    tempTopFlavors.sort((a, b) => b.value.compareTo(a.value));

    return tempTopFlavors;
  }

  static ProductReview? _getMyReview(List<ProductReview> reviews) {
    UserModel user = getIt<SharedPrefsManager>().getUser();

    for (ProductReview review in reviews) {
      if (review.userId == user.userId) {
        return review;
      }
    }
    return null;
  }

  static List<ProductReview> _getAllReviews(List json, String prodId) {
    if (json.isEmpty) return [];

    return json.map((review) {
      ProductReview productReview = ProductReview.fromJson(review, prodId);

      return productReview;
    }).toList();
  }

  // static List<FlavorModel> _gatAllFlavors(List json) {
  //   if (json.isEmpty) return [];

  //   return json.map((flavor) => FlavorModel.fromJson(flavor)).toList();
  // }

  static double _getRating(List<ProductReview> reviews) {
    double rating = 0.0;
    for (ProductReview review in reviews) {
      rating += review.rating;
    }

    if (rating == 0.0) return rating;

    return double.parse((rating / reviews.length).toStringAsFixed(1));
  }

  // @override
  // String toString() {
  //   return "";
  // }
}
