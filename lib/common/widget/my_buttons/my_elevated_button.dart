import 'package:magueyapp/common/widget/text_view.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

import '../../../theme/my_colors.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double height, iconSpacing, buttonRadius;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double elevation;

  const MyElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonBGColor,
    this.height = 52,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.width,
    this.padding,
    this.iconSpacing = 10,
    this.buttonRadius = 8,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? 16.paddingH(context),
      child: SizedBox(
        height: height.pxH(context),
        width: width == null
            ? MediaQuery.sizeOf(context).width
            : width!.pxH(context),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              onPressed != null
                  ? MyColors.black0D0D0D
                  : MyColors.tapSplashColor,
            ),
            elevation: MaterialStateProperty.all(elevation),
            shadowColor:
                MaterialStateProperty.all(MyColors.black0D0D0D.withOpacity(01)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius.pxV(context)),
              ),
            ),
          ),
          child: FittedBox(
            child: Row(
              children: [
                prefixIcon ?? const SizedBox(),
                SizedBox(width: iconSpacing),
                TextView(
                  text,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                  style: textStyle ?? myTextStyle.font_12w400,
                ),
                SizedBox(width: iconSpacing),
                suffixIcon ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
