import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magueyapp/common/widget/custom_circular_loader.dart';
import 'package:magueyapp/common/widget/my_buttons/my_elevated_button.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/view_model/json.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/presentation/shop/view_model/temp_shops_data.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class UploadProductsScreen extends StatelessWidget {
  static const String route = "upload_products";
  const UploadProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            button(
              context,
              text: "Add Products",
              tap: () async => await _uploadProducts(),
            ),
            button(
              context,
              text: "Add A Review",
              tap: () async => await _addReview(),
            ),
            button(
              context,
              text: "Get A Product",
              tap: () async => await _getProductById("AkBuItW5kJ3dggBBwqF3"),
            ),
            button(
              context,
              text: "Add Shops",
              tap: () async => await _uploadShop(),
            ),
            button(
              context,
              text: "Add Events",
              tap: () async => await _uploadEvent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(
    BuildContext context, {
    required String text,
    required Function() tap,
  }) {
    return MyElevatedButton(
      onPressed: tap,
      padding: 10.paddingBottom(context),
      text: text,
      width: 85.percentWidth(context),
    );
  }

  Future<void> _getProductById(String id) async {
    CustomCircularLoader.showLoaderDialog();
    var _ins = FirebaseFirestore.instance;

    var doc =
        await _ins.collection(CollectionNames.productsCollection).doc(id).get();
    // .doc("6r2gc7yrZ774D9xYxc86");
    Map<String, dynamic> productInfo = doc.data()!;

    var reviewDoc = await _ins
        .collection(CollectionNames.productsCollection)
        .doc(id)
        .collection(CollectionNames.reviewCollection)
        .get();
    Map<String, dynamic> reviews = {"reviews": []};
    for (QueryDocumentSnapshot reviewSnapshot in reviewDoc.docs) {
      var review = reviewSnapshot.data() as Map<String, dynamic>;
      review.addEntries({"id": reviewSnapshot.id}.entries);
      reviews['reviews'].add(review);
    }
    productInfo.addEntries(reviews.entries);
    ProductModel prod = ProductModel.fromJson(productInfo, id);
    print(prod);
    CustomCircularLoader.dispose();
  }

  Future<void> _addReview() async {
    String docID = "AkBuItW5kJ3dggBBwqF3";
    CustomCircularLoader.showLoaderDialog();
    var _ins = FirebaseFirestore.instance;

    var doc = _ins.collection(CollectionNames.productsCollection).doc(docID);
    // .doc("6r2gc7yrZ774D9xYxc86");

    for (Map<String, dynamic> review in reviews) {
      ProductReview model = ProductReview.fromJson(review, docID);
      Map<String, dynamic> json = model.toJson();
      // print(json);
      await doc.collection(CollectionNames.reviewCollection).add(json);
    }

    CustomCircularLoader.dispose();
  }

  Future<void> _uploadProducts() async {
    CustomCircularLoader.showLoaderDialog();
    var _ins = FirebaseFirestore.instance;
    for (Map<String, dynamic> data in productsJson) {
      await _ins.collection(CollectionNames.productsCollection).add(data);
    }

    CustomCircularLoader.dispose();
  }

  Future<void> _uploadShop() async {
    CustomCircularLoader.showLoaderDialog();
    var _ins = FirebaseFirestore.instance;
    for (Map<String, dynamic> data in shopsData) {
      await _ins.collection(CollectionNames.shopCollection).add(data);
    }

    CustomCircularLoader.dispose();
  }

  Future<void> _uploadEvent() async {
    CustomCircularLoader.showLoaderDialog();
    var _ins = FirebaseFirestore.instance;
    for (Map<String, dynamic> data in events) {
      await _ins.collection(CollectionNames.eventCollection).add(data);
    }

    CustomCircularLoader.dispose();
  }
}

List<Map<String, dynamic>> reviews = [
  {
    "user_id": "mohsin22@gmail.com",
    "user_name": "Mohsin22",
    "user_profile_pic": "",
    "rating": 3,
    "note":
        "The experience was good and the delivery services are really remarkable",
    "flavour_tags": [],
    "create_date": DateTime.now().toString(),
  },
  {
    "user_id": "mohsin1@gmail.com",
    "user_name": "Mohsin1",
    "user_profile_pic": "",
    "rating": 4,
    "note":
        "The experience was awesome and the delivery services are truly on-point",
    "flavour_tags": [],
    "create_date": DateTime.now().toString(),
  },
  {
    "user_id": "jason.eli.gluck@gmail.com",
    "user_name": "Jason.eli.gluck",
    "user_profile_pic": "",
    "rating": 2,
    "note":
        "The experience was disappointing. There must be something in complementry or a money-back policy",
    "flavour_tags": [],
    "create_date": DateTime.now().toString(),
  }
];

List<Map<String, dynamic>> events = [
  {
    "name": "Los Ocotales Mezcal Tasting",
    "image_url":
        "https://drive.google.com/file/d/1MgJza261Wx5X4zWldFrsgWcsrcQR6-lQ/view",
    "location": {
      "latitude": "34.117964124551165",
      "longitude": "-118.26063963554951",
      "address": "3216 Glendale Blvd, Los Angeles, CA 90039",
      "city": "Los Angeles",
      "state": "CA",
      "name": "Sagrado Mezcaleria"
    },
    "timings": {"start_time": "05:00 pm", "end_time": "08:00 pm"},
    "description":
        "Join us for a brand presentation with Samuel Santiago from Mezcal Los Ocotales",
    "create_date": DateTime.now().toString(),
    "event_date": DateFormat("MM/dd/yyyy").parse("03/09/2024").toString(),
    "price": "\$50.00",
    "event_link":
        "https://www.eventbrite.com/e/mezcal-tasting-with-maestro-samuel-santiago-from-los-ocotales-tickets-850897857397?utm-campaign=social&utm-content=attendeeshare&utm-medium=discovery&utm-term=listing&utm-source=cp&aff=ebdsshcopyurl"
  },
  {
    "name": "Amigas y Mezcal",
    "image_url":
        "https://drive.google.com/file/d/1qFCO4R1GAdCO2Wx_pZV6pSgMyiE1983J/view",
    "location": {
      "latitude": "34.42059167840114",
      "longitude": "-118.5637471625157",
      "address": "27007 McBean Pkwy, Valencia, CA 91355",
      "city": "Valencia",
      "state": "CA",
      "name": "Madre - Santa Clarita"
    },
    "timings": {"start_time": "06:30 pm", "end_time": "09:30 pm"},
    "description":
        "12 mezcales + 3 course dinner. Presented by Salvadores Mezcal, Hacienda Oponguio, and Mezcal Rambha in honor of Women's History Month.",
    "create_date": DateTime.now().toString(),
    "event_date": DateFormat("MM/dd/yyyy").parse("03/07/2024").toString(),
    "price": "\$130.00",
    "event_link":
        "https://resy.com/cities/sntc/venues/madre-restaurant-santa-clarita/events/amigas-amigos-y-mezcal-2024-03-07?date=2024-03-05&seats=2"
  },
];
