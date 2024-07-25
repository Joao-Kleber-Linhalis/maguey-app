import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/catrgory/model/category_model.dart';
import 'package:magueyapp/presentation/catrgory/ui/screen/category_screen.dart';
import 'package:magueyapp/presentation/catrgory/view_model/sub_category_json.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/ui/screen/all_products_screen.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/string.dart';
import 'package:redux/redux.dart';

class HomeCategoryModel {
  final String id;
  Color color;
  String imageUrl;
  String title;

  HomeCategoryModel({
    required this.color,
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    String color1Code = json['color'];
    if (color1Code[0] == "#") {
      color1Code = "0xff${color1Code.substring(1)}";
    } else {
      color1Code = "0xff${json['color']}";
    }

    // String imageUrl = getDriveViewableLink(json['imageUrl']);
    String imageUrl = json['imageUrl'];

    return HomeCategoryModel(
      color: Color(int.parse(color1Code)),
      id: json['id'].toString(),
      imageUrl: imageUrl,
      title: json['title'].toString().capitalizeFirstLetter(),
    );
  }

  void onTapOfCategory(BuildContext context, Store<ProductState> store) {
    bool hasSubcategories = subcategoriesContains(id);

    store.dispatch(ProductCategoryOnTap(title, null));

    context.pushNamed(
      hasSubcategories ? CategoryScreen.route : AllProductsScreen.route,
    );
  }

  bool subcategoriesContains(String catId) {
    List<CategoryModel> categories =
        categoriesJson.map((e) => CategoryModel.fromJson(e)).toList();

    for (CategoryModel category in categories) {
      if (category.categoryId == catId) return true;
    }

    return false;
  }
}
