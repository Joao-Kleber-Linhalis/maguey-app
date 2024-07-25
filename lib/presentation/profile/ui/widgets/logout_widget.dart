import 'package:flutter/material.dart';
import 'package:magueyapp/common/dialogs/my_cupertino_dialog.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

void logout(BuildContext context, {required Function() onLogoutTap}) {
  showDialog(
    context: context,
    builder: (context) => Material(
      type: MaterialType.transparency,
      child: MyCupertinoDialogBox(
        mainHeading: "Logout Confirmation",
        message: "Are you sure that you wanna logout",
        cancelButtonText: "Cancel",
        buttonText: "Logout",
        actionCancelButton: () => context.pop(),
        actionCallBack: onLogoutTap,
        showActionButton: true,
      ),
    ),
  );
}
