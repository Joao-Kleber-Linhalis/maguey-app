import 'package:flutter/material.dart';
import 'package:magueyapp/data/brand_controller.dart';
import 'package:magueyapp/data/event_controller.dart';
import 'package:magueyapp/data/product_controller.dart';
import 'package:magueyapp/data/shopController.dart';
import 'package:magueyapp/entity/event_entity.dart';
import 'package:magueyapp/entity/mezcal_product.dart';

import '../data/category_controller.dart';
import '../data/user_controller.dart';
import '../entity/brand_entity.dart';
import '../entity/category_entity.dart';
import '../entity/shops.dart';
import '../entity/user_entity.dart';
import '../infra/firebase_controller.dart';

class DashboardProvider with ChangeNotifier {
  static final DashboardProvider provider = DashboardProvider._internal();

  factory DashboardProvider() {
    return provider;
  }
  DashboardProvider._internal();
  FirebaseController firebaseController = FirebaseController();
  UserController userController = UserController();
  EventController eventController = EventController();
  ShopController shopController = ShopController();
  CategoryController categoryController = CategoryController();
  MezcalProductController productsController = MezcalProductController();
  BrandController brandController = BrandController();
  double heightDashBoardHeader = 468;
  UserEntity currentUser = UserEntity(
    id: '',
    email: '',
    profilePicture: '',
    createdAt: DateTime.now(),
    favoriteProducts: [],
    favoriteEvents: [],
  );
  List<EventEntity> events = [];
  List<ShopEntity> shops = [];
  List<ShopEventEntity> shopEventList = [];
  List<Category> categories = [];
  List<Product> products = [];
  List<Brand> brands = [];

  Future<UserEntity> loadDataGetUserInformation() async {
    try {
      UserEntity newUser = await userController.searchUser(firebaseController.getCurrentUser()!.uid);
      events = await eventController.searchAllEvents();
      shops = await shopController.searchAllShops();
      categories = await categoryController.searchAllCategories();
      brands = await brandController.searchAllBrand();
      products = await productsController.searchAllProducts();
      currentUser = newUser;
      initializeShopEventList();
      return newUser;
    } catch (e) {
      print(e);
      throw Exception('Something went wrong');
    }
  }

  void initializeShopEventList() {
    for (var event in events) {
      shopEventList.add(ShopEventEntity(
        name: event.name,
        id: event.id,
        imageUrl: event.imageUrl,
        createDate: event.createDate,
        description: event.description,
        townName: event.townName,
        latitude: event.latitude,
        longitude: event.longitude,
        address: event.address,
        //link: event.link,
        type: 'event',
        link: '',
      ));
    }

    for (var shop in shops) {
      shopEventList.add(ShopEventEntity(
        name: shop.name,
        id: shop.id,
        imageUrl: shop.imageUrl,
        createDate: shop.createDate,
        description: shop.description,
        townName: shop.townName,
        latitude: shop.latitude,
        longitude: shop.longitude,
        address: shop.address,
        //link: shop.link,
        type: 'shop',
        link: '',
      ));
    }
  }
}

class ShopEventEntity {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime? createDate;
  final String? openingTime, closingTime;
  final String description;
  final String townName;
  final double? latitude;
  final double? longitude;
  final String address;
  final String? contact;
  final String link;
  final String type;

  ShopEventEntity({
    required this.name,
    required this.id,
    required this.imageUrl,
    this.openingTime,
    this.closingTime,
    this.createDate,
    required this.description,
    required this.townName,
    this.latitude,
    this.longitude,
    required this.address,
    this.contact,
    required this.link,
    required this.type,
  });
}
