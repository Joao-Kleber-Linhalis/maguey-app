import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/widgets/custom_app_bar.dart';
import 'package:magueyapp/theme/my_colors.dart';
class MeReviews extends StatelessWidget {
  const MeReviews({super.key});

  static void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeReviews(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text("Teste"),
      ),
    );
  }
}