import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class CustomCircularLoader {
  static Future<void> showLoaderDialog() async {
    showDialog(
      context: GlobalContext.currentContext!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: MyColors.greyF5F5F5,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: 16.paddingAll(context),
            child: const CupertinoActivityIndicator(
              color: MyColors.black0D0D0D,
              radius: 18,
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> dispose() async {
    Navigator.pop(GlobalContext.currentContext!);
  }
}
