import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/responsive/responsive.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget({super.key});

  final List<String> categorys = [
    //Mock test
    "Agave",
    "Bacanora",
    "Mezcal",
    "Raicilla",
    "Sotol",
  ];

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = Responsive.widthOfScreen(context);
    double heightOfScreen = Responsive.heightOfScreen(context);
    return Column(
      children: [
        Column(
          children: List.generate(categorys.length, (index) {
            //List item generate
            return Column(
              children: [
                _buildDivider(), //Divisor
                _buildListItem(
                  title: categorys[index],
                  onTap: () {},
                  heightOfScreen: heightOfScreen,
                  widthOfScreen: widthOfScreen,
                ), //Every list item
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required VoidCallback onTap,
    required double heightOfScreen,
    required double widthOfScreen,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: heightOfScreen * 0.046667,
          vertical: widthOfScreen * 0.0488),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap, //On Tap
            child: AutoSizeText(
              //Title on right
              title,
              style: TextStyle(
                fontFamily: 'CircularAirPro',
                fontSize: heightOfScreen * 0.04,
                height: heightOfScreen * 0.001750,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE3FF0A),
              ),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              // "subtitle" on left
              "A BLURB ABOUT ${title.toUpperCase()} HERE",
              style: TextStyle(
                fontFamily: 'CircularXXMono',
                fontSize: heightOfScreen * 0.000962,
                height: heightOfScreen * 0.001517,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.04,
                color: const Color(0xFFE2D7C1),
              ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF908C00),
      thickness: 0.5,
      height: 30,
    );
  }
}
