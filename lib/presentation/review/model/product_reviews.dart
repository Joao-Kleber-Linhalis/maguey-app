
class ProductReview {
  final String id, userId, productId;
  final String userName, profileImageUrl, note;
  final double rating;
  final List flavors;
  final DateTime createDate;

  const ProductReview({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
    required this.rating,
    required this.note,
    required this.flavors,
    required this.createDate,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json, String prodId) {
    final String profilePic = json['user_profile_pic'] ?? "";
    return ProductReview(
      id: json['id'].toString(),
      productId: prodId,
      userId: json['user_id'].toString(),
      userName: json['user_name'],
      profileImageUrl: profilePic,
      rating: double.parse(json['rating'].toString()),
      note: json['note'],
      flavors: json['flavour_tags'],
      createDate: DateTime.parse(json['create_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "user_name": userName,
      "user_profile_pic": profileImageUrl,
      "rating": rating,
      "note": note,
      "flavour_tags": flavors,
      "create_date": DateTime.now().toString(),
    };
  }
}


// {
//             "id": "String",
//             "user_id": "String",
//             "user_name": "String",
//             "product_id": "String",
//             "user_profile_pic": "String",
//             "rating": "int",
//             "note": "String",
//             "flavour_tags": ["String"]
//         }