import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';

class ProductListScreen extends StatelessWidget {
  static const String route = 'product-list-screen';

  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Transform.rotate(
                angle: _grausParaRadianos(-90),
                child: Image.asset(
                  MyIcons.brandIcon, // Replace with your logo
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52,
                  width: 345,
                  child: TextField(
                    style: TextStyle(color: MyColors.green667085, fontSize: 15),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                          color: MyColors.green667085,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                      hintText: "Search within, let the Spirits speak to you",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      fillColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  _productItemList(),
                  _productItemList(),
                  _productItemList(),
                  _productItemList(),
                  _productItemList(),
                  _productItemList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double _grausParaRadianos(double graus) {
    return graus * 3.1415927 / 180;
  }
}

Widget _productItemList() {
  return Column(
    children: [
      const Divider(
        color: MyColors.greenE3FF0A,
        thickness: 1.15,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Enchanted",
              style: TextStyle(
                  color: MyColors.greenE3FF0A,
                  fontFamily: "CircularAirPro",
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 68,
              width: 98,
              child: Image.asset(
                "assets/images/temp/enchanted_ensamble.jpeg",
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      )
    ],
  );
}
