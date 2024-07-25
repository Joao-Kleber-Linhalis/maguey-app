// ignore_for_file: inference_failure_on_function_return_type, always_declare_return_types, type_annotate_public_apis

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class MyCupertinoDialogBox extends StatelessWidget {
  final String? mainHeading, message, buttonText, cancelButtonText;
  final VoidCallback? actionCallBack, actionCancelButton;
  final bool isCancelTextBold, isActionTextBold;
  final bool showActionButton;

  const MyCupertinoDialogBox({
    Key? key,
    this.mainHeading,
    this.message,
    this.buttonText,
    this.cancelButtonText,
    this.actionCallBack,
    this.actionCancelButton,
    this.isCancelTextBold = false,
    this.isActionTextBold = false,
    this.showActionButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: TextView(
        mainHeading ?? "please type your message",
        maxLine: 5,
        style: myTextStyle.font_20w800Black.w600,
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextView(
          message ?? "",
          maxLine: 5,
          textAlign: TextAlign.center,
          style: myTextStyle.font_16w600Black.w500,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: TextView(
            cancelButtonText ?? "Cancel",
            style: myTextStyle.font_14w400.copyWith(
                color: Colors.blue,
                fontSize: 18,
                fontWeight:
                    isCancelTextBold ? FontWeight.bold : FontWeight.normal),
          ),
          onPressed: () {
            actionCancelButton!();
          },
        ),
        if (showActionButton)
          CupertinoDialogAction(
            child: TextView(
              buttonText ?? "Yes",
              style: myTextStyle.font_12w400.copyWith(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight:
                      isActionTextBold ? FontWeight.bold : FontWeight.normal),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              actionCallBack!();
            },
          )
      ],
    );
  }
}
