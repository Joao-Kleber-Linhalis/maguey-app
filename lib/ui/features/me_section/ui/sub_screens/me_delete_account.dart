import 'package:flutter/material.dart';

import '../../../../../infra/firebase_manager.dart';
import '../../../../../theme/my_colors.dart';
import '../../../../../theme/text_styling.dart';

class MeDeleteAccount extends StatelessWidget {
  const MeDeleteAccount({super.key});

  static void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return const MeDeleteAccount();
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
        "Delete Account",
        style: TextStyleCustom().font_12w400.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.yellowE2D7C1,
              fontSize: 20,
              fontFamily: "CircularAirPro",
            ),
      ),
      content: Text(
        "Are you sure you want to delete your account permanently? This action cannot be undone.",
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
            "Delete",
            style: TextStyleCustom().font_12w400.copyWith(
                  fontWeight: FontWeight.normal,
                  color: MyColors.orangeFD5944, //Text Color, maybe change
                  fontSize: 15,
                  fontFamily: "CircularAirPro",
                ),
          ),
          onTap: () async {
            Navigator.of(context).pop();
            FirebaseManager().deleteUser(context);
            // AppRoutes.replace(context, const LogInScreen());
          },
        ),
        InkWell(
          child: Text(
            "Cancel",
            style: TextStyleCustom().font_12w400.copyWith(
                  fontWeight: FontWeight.normal,
                  color: MyColors.greenE3FF0A, //Text Color, maybe change
                  fontSize: 15,
                  fontFamily: "CircularAirPro",
                ),
          ),
          onTap: () {
            Navigator.of(context).pop(); // Just close the dialog
          },
        ),
      ],
    );
  }
}
