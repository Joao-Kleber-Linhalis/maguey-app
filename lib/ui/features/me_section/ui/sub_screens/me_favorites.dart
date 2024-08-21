import 'package:flutter/material.dart';

import '../../../../../custom_app_bar.dart';
import '../../../../../theme/my_colors.dart';

class MeFavoritesProducts extends StatelessWidget {
  const MeFavoritesProducts({super.key});

  static void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MeFavoritesProducts(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text("Teste"),
          ),
        ],
      ),
    );
  }
  /*
  AutoSizeText(
      //Title on right
      title,
      style: TextStyle(
        fontFamily: 'CircularAirPro',
        fontSize: heightOfScreen * 0.02,
        height: heightOfScreen * 0.001750,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFE3FF0A),
      ),
    ),
  */
}
