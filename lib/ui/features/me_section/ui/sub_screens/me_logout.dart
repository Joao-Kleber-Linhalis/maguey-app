import 'package:flutter/material.dart';

import '../../../../../infra/firebase_manager.dart';
import '../../../../../theme/my_colors.dart';
import '../../../../../theme/text_styling.dart';

class MeLogout extends StatelessWidget {
  const MeLogout({super.key});

  static void showLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return const MeLogout();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.black2B2B2B,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Logout",
        style: TextStyleCustom().font_12w400.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.yellowE2D7C1,
              fontSize: 20,
              fontFamily: "CircularAirPro",
            ),
      ),
      content: Text(
        "Are you sure you want to log out?",
        style: TextStyleCustom().font_12w400.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.yellowE2D7C1,
              fontSize: 15,
              fontFamily: "CircularAirPro",
            ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        InkWell(
          child: Text(
            "Confirm",
            style: TextStyleCustom().font_12w400.copyWith(
                  fontWeight: FontWeight.normal,
                  color: MyColors.greenE3FF0A, //Text Color, maybe change
                  fontSize: 15,
                  fontFamily: "CircularAirPro",
                ),
          ),
          onTap: () async {
            await FirebaseManager().signOut(context: context);
            if (context.mounted) {
              Navigator.of(context).pop(); // Fecha o diálogo
            }
          },
        ),
        InkWell(
          child: Text(
            "Cancel",
            style: TextStyleCustom().font_12w400.copyWith(
                  fontWeight: FontWeight.normal,
                  color: MyColors.orangeFD5944, //Text Color, maybe change
                  fontSize: 15,
                  fontFamily: "CircularAirPro",
                ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
