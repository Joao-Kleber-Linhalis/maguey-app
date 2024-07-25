import 'dart:ui';

import 'package:magueyapp/common/functions/drive_image_viewable_link.dart';

class CategoryModel {
  final String id, categoryId;
  String title;
  Color darkColor, lightColor;
  String? imageUrl;
  num titleFontSize;

  CategoryModel({
    required this.id,
    required this.title,
    required this.darkColor,
    required this.lightColor,
    required this.imageUrl,
    required this.titleFontSize,
    required this.categoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String color1Code = json['color1'], color2Code = json['color2'];
    if (color1Code[0] == "#") {
      color1Code = "0xff${color1Code.substring(1)}";
    } else {
      color1Code = "0xff${json['color1']}";
    }

    if (color2Code[0] == "#") {
      color2Code = "0xff${color2Code.substring(1)}";
    } else {
      color2Code = "0xff${json['color2']}";
    }

    String? imageUrl;
    if (json['imageUrl'] != null) {
      imageUrl = getDriveViewableLink(json['imageUrl']);
    }
    return CategoryModel(
      id: json['id'].toString(),
      title: json['title'].toString().toUpperCase(),
      darkColor: Color(int.parse(color1Code)),
      lightColor: Color(int.parse(color2Code)),
      imageUrl: imageUrl,
      titleFontSize: json['titleFontSize'] ?? 57,
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "titleFontSize": titleFontSize,
      "color1": darkColor,
      "color2": lightColor,
      "imageUrl": imageUrl,
      "category_id": categoryId,
    };
  }
}
