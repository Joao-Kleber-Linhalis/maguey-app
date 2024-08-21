import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/text_styling.dart';
import 'package:magueyapp/widgets/text_view.dart';

import '../theme/my_colors.dart';

class MyOutlineButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double height, buttonRadius, outlineWidth;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final double iconSpacing;

  const MyOutlineButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.buttonBGColor,
    this.height = 48,
    this.width,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.outlineWidth = 2,
    this.padding = EdgeInsets.zero,
    this.iconSpacing = 10,
    this.buttonRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height.pxH(context),
        width: width == null ? 100.percentWidth(context) : width!.pxH(context),
        child: InkWell(
          splashColor: textColor?.withOpacity(0.05) ?? MyColors.tapSplashColor,
          onTap: onPressed,
          child: OutlinedButton(
            onPressed: onPressed,
            // height: height.pxH(context),
            // width:
            // width == null ? 100.percentWidth(context) : width!.pxH(context),
            // onPressed: onPressed,
            // decoration: BoxDecoration(
            // color: textColor?.withOpacity(0.05) ?? MyColors.tapSplashColor,
            // borderRadius: BorderRadius.circular(buttonRadius.pxV(context)),
            // ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                textColor?.withOpacity(0.05) ?? MyColors.tapSplashColor,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius.pxV(context)),
                ),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                  width: outlineWidth,
                  color: onPressed != null ? textColor ?? MyColors.black0D0D0D : Colors.transparent,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  prefixIcon ?? const SizedBox(),
                  SizedBox(width: iconSpacing),
                  TextView(
                    text,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                    style: textStyle ?? TextStyleCustom().font_13w700.copyWith(color: MyColors.black0D0D0D),
                  ),
                  SizedBox(width: iconSpacing),
                  suffixIcon ?? const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
