abstract class Entity {
  late final String id;

  Entity({required this.id});

  Map<String, dynamic> toJson();

}