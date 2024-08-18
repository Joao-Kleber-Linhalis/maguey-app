import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/brand_select/ui/screen/brand_select_screen.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/service/firebase_service/firebase_service.dart';
import 'package:magueyapp/theme/my_colors.dart';

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
    var firebaseService = getIt<FirebaseService>();
    return AlertDialog(
      backgroundColor: MyColors.black2B2B2B,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Logout",
        style: textStyles.font_12w400.copyWith(
          fontWeight: FontWeight.normal,
          color: MyColors.yellowE2D7C1,
          fontSize: 20,
          fontFamily: "CircularAirPro",
        ),
      ),
      content: Text(
        "Are you sure you want to log out?",
        style: textStyles.font_12w400.copyWith(
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
            style: textStyles.font_12w400.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.greenE3FF0A, //Text Color, maybe change
              fontSize: 15,
              fontFamily: "CircularAirPro",
            ),
          ),
          onTap: () async {
            try {
              await firebaseService.globalLogout();
              Navigator.pushReplacementNamed(context, "/");
            } catch (e) {
              print('Erro ao fazer logout: $e');
            } finally {
              Navigator.of(context).pop();
            }
          },
        ),
        InkWell(
          child: Text(
            "Cancel",
            style: textStyles.font_12w400.copyWith(
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
