import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class ToolTipImage extends StatelessWidget {
  final String message;
  final bool rotate;
  final double placeText;
  const ToolTipImage({
    super.key,
    required this.message,
    this.rotate = false,
    this.placeText = 01,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.greyD9D9D9,
      padding: 5.paddingAll(context),
      child: TextView(
        message,
        style: myTextStyle.font_10w400Black,
      ),
    );
  }
}
