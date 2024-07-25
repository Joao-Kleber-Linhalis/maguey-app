import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class TextButtonRow extends StatelessWidget {
  final String message, buttonText;
  final Function() onTap;
  const TextButtonRow({
    super.key,
    required this.buttonText,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
          message,
          style: myTextStyle.font_13w700Black,
        ),
        TextView(
          buttonText,
          style: myTextStyle.font_13w700.copyWith(color: MyColors.green658F7B),
          padding: 4.paddingH(context),
          onTap: onTap,
        )
      ],
    );
  }
}
