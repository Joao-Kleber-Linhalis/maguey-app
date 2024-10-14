import 'entity.dart';

class UserEntity extends Entity {
  final String email;
  final String profilePicture;
  final DateTime createdAt;
  final List<dynamic> favoriteProducts;
  final List<dynamic> favoriteEvents;

  UserEntity({
    required super.id,
    required this.email,
    required this.profilePicture,
    required this.createdAt,
    required this.favoriteProducts,
    required this.favoriteEvents,
  });
  //String formattedDate = DateFormat('MMMM yyyy').format(json['createdAt'].toDate());

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
      favoriteProducts: json['favoriteProducts'] ?? [],
      favoriteEvents: json['favoriteEvents'] ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'profilePicture': profilePicture,
      'createdAt': DateTime.now(),
      'favoriteProducts': favoriteProducts,
      'favoriteEvents': favoriteEvents,
    };
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? profile_picture,
    DateTime? createdAt,
    List<String>? favoriteProducts,
    List<String>? favoriteEvents,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      profilePicture: profile_picture ?? profilePicture,
      createdAt: createdAt ?? this.createdAt,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteEvents: favoriteEvents ?? this.favoriteEvents,
    );
  }

  UserEntity.empty() : this(id: '', email: '', profilePicture: '', createdAt: DateTime.now(), favoriteProducts: [], favoriteEvents: []);
}
