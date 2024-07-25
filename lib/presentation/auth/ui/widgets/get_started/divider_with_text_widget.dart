import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

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
          width: 66.pxH(context),
        ),
        TextView(text, style: style),
        Container(
          color: MyColors.greyD9D9D9,
          height: 2.pxV(context),
          width: 66.pxH(context),
        ),
      ],
    );
  }
}
