import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/text_view.dart';

import '../theme/my_colors.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const DividerWithText({
    super.key,
    required this.style,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: MyColors.greyD9D9D9,
          height: 2.pxV(context),
          width: 130.pxH(context),
        ),
        TextView(text, style: style),
        Container(
          color: MyColors.greyD9D9D9,
          height: 2.pxV(context),
          width: 130.pxH(context),
        ),
      ],
    );
  }
}
