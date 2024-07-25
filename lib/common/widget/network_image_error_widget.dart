import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

errorWidget(
  BuildContext context,
  String str,
  Object? obj,
  double width,
) =>
    MyImageErrorWidget(
      width: width,
      child: Image.asset("${MyImages.tempFolderPath}/bottle1.png"),
    );

class MyImageErrorWidget extends StatelessWidget {
  final double width;
  final Color textColor;
  final Widget? child;
  const MyImageErrorWidget({
    super.key,
    required this.width,
    this.textColor = MyColors.whiteFFFFFF,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: child ??
          Center(
            child: Placeholder(
              strokeWidth: 1,
              color: textColor,
              child: TextView(
                "Image Loading Failed..",
                style: myTextStyle.font_10w400Black.copyWith(color: textColor),
                textAlign: TextAlign.center,
                padding: 24.paddingV(context),
              ),
            ),
          ),
    );
  }
}
