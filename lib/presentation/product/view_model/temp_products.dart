// import 'package:magueyapp/presentation/product/model/product_model.dart';

// List<ProductModel> products = [
//   ProductModel.fromJson(addJson(1, "D85229")),
//   ProductModel.fromJson(addJson(2, "9DB139")),
//   ProductModel.fromJson(addJson(3, "9DB137")),
//   ProductModel.fromJson(addJson(4, "D27001")),
//   ProductModel.fromJson(addJson(5, "008BB4")),
//   ProductModel.fromJson(addJson(6, "#FFA64A")),
// ];

// Map<String, dynamic> addJson(int id, String color) {
//   json['id'] = id;
//   json['color'] = color;
//   return json;
// }

Map<String, dynamic> json = {
  "id": 1,
  "category": {"id": 1, "name": "Blended"},
  "image_url": "",
  "color": "#D85229",
  "name": "Blended malt",
  "manufacturer": {"name": "Monkey shoulder"},
  "description":
      'For a more professional and refined aesthetic, you might want to consider using "Helvetica Neue" or "Garamond." These fonts are known for their timeless and sophisticated appearance, making them suitable for a professional and upscale online wine delivery app. For a more professional and refined aesthetic, you might want . eir timeless and sophisticated appearance, making them suitable for a professional and upscale online wine delivery app. For a more professional and refined aesthetic, you might want .',
  "price": "\$\$\$",
  "flavours": [
    "Flavor 1",
    "Flavor 2",
    "Flavor 3",
    "Flavor 4",
  ],
  "information": [
    {"key": "Producer", "value": "O'Malley's Distillery"},
    {"key": "Alcohol by Volume (ABV)", "value": "40%"},
    {"key": "Country of Origin", "value": "Ireland"},
    {"key": "Age", "value": "Age"},
  ],
  "reviews": [
    {
      "id": 1,
      "user_id": 1,
      "product_id": 5,
      "user_name": "Abc",
      "user_profile_pic": "",
      "create_date": DateTime.now().toString(),
      "rating": 4,
      "note":
          'For a more professional and refined aesthetic, you might want to consider using "Helvetica Neue" or "Garamond." These fonts are known for their timeless.',
      "flavour_tags": ["String", "Gum", "Bun"]
    },
    {
      "id": 2,
      "user_id": 2,
      "product_id": 5,
      "user_name": "Abc",
      "user_profile_pic": "",
      "create_date": DateTime.now().toString(),
      "rating": 3,
      "note":
          'For a more professional and refined aesthetic, you might want to consider using "Helvetica Neue" or "Garamond." These fonts are known for their timeless.',
      "flavour_tags": ["String", "Gum", "Bun", "Amb", "VVV", "Zal"]
    },
    {
      "id": 3,
      "user_id": 3,
      "product_id": 5,
      "user_name": "Abc",
      "user_profile_pic": "",
      "create_date": DateTime.now().toString(),
      "rating": 2.5,
      "note":
          'For a more professional and refined aesthetic, you might want to consider using "Helvetica Neue" or "Garamond." These fonts are known for their timeless.',
      "flavour_tags": ["Gum", "Bun", "Amb", "VVV", "Goal", "Abid"]
    },
  ]
};
