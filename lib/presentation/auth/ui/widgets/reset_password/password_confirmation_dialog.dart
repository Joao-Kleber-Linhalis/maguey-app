import 'package:flutter/material.dart';
import 'package:magueyapp/common/dialogs/my_cupertino_dialog.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

void confirmationDialog(BuildContext context, String email) {
  showDialog(
    context: context,
    builder: (context) => Material(
      type: MaterialType.transparency,
      child: MyCupertinoDialogBox(
        mainHeading: "Email Verification",
        message: "An Email has been sent to $email for verification.",
        cancelButtonText: "Ok",
        actionCancelButton: () {
          context.pushNamedAndRemoveUntil(GetStartedScreen.route);
        },
        showActionButton: false,
      ),
    ),
  );
}
