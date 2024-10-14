import 'entity.dart';

class ReviewEntity extends Entity {
  String imageUrl;
  String title;
  String rating;
  String reviewText;
  String productId;
  String userId;

  ReviewEntity({
    required super.id,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviewText,
    required this.productId,
    required this.userId,
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    return ReviewEntity(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      rating: json['rating'],
      reviewText: json['reviewText'],
      productId: json['productId'],
      userId: json['userId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'rating': rating,
      'reviewText': reviewText,
      'productId': productId,
      'userId': userId,
    };
  }

  ReviewEntity copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? rating,
    String? reviewText,
    String? productId,
    String? userId,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
    );
  }
}
