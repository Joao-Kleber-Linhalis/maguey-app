import 'package:flutter/material.dart';

import '../../../../../custom_app_bar.dart';
import '../../../../../theme/my_colors.dart';

class MeEventsEvents extends StatelessWidget {
  const MeEventsEvents({super.key});

  static void navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MeEventsEvents(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: CustomAppBar(),
      body: Center(
        child: Text("Teste"),
      ),
    );
  }
}
