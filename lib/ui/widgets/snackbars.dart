import 'package:flutter/material.dart';
import 'package:magueyapp/main.dart';

import '../../design_system/Text/ds_text.dart';
import '../../design_system/colors.dart';
import '../../theme/my_colors.dart';

class ShowSnackBar {
  int? durationInSeconds;
  BuildContext context;
  Color? color;
  bool? doesItAppearAtTheBottom;

  ShowSnackBar({required this.context, this.color, this.durationInSeconds, this.doesItAppearAtTheBottom = false});

  void showSnackBar({required String message, Color? backgroundColor}) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(
        bottom: doesItAppearAtTheBottom! ? 12 : 140,
        left: 16,
        right: 16,
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor!.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DSButtonTextWhite(
          buttonText: message,
        ),
      ),
      backgroundColor: DSColors.transparent,
      dismissDirection: DismissDirection.horizontal,
      duration: durationInSeconds == null ? const Duration(seconds: 5) : Duration(seconds: durationInSeconds!),
      behavior: SnackBarBehavior.floating,
      /*action: SnackBarAction(
            textColor: DSColors.whiteColor,
            label: 'OK',
          onPressed: () {

          },
        ),*/
    ));
  }

  void showErrorSnackBar({required String message, Color? color, int? durationInSeconds}) {
    showSnackBar(
      message: message,
      backgroundColor: color ?? MyColors.black2B2B2B,
    );
  }
}
