import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

import '../../../theme/my_colors.dart';

class MyLoaderElvButton extends StatelessWidget {
  final bool loader;
  final Function()? onPressed;
  final String text;
  final Widget? prefixIcon, suffixIcon;
  final Color? buttonBGColor, disabledTextColor, textColor;
  final double height, loaderWidth, borderRadius;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final double iconSpacing;
  final List<BoxShadow>? boxShadow;

  const MyLoaderElvButton({
    Key? key,
    required this.text,
    required this.loader,
    this.onPressed,
    this.buttonBGColor,
    this.height = 52,
    this.loaderWidth = 52,
    this.disabledTextColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.width,
    this.padding = EdgeInsets.zero,
    this.iconSpacing = 10,
    this.borderRadius = 6,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        margin: padding,
        decoration: BoxDecoration(
          color: onPressed != null
              ? buttonBGColor ?? MyColors.black0D0D0D
              : MyColors.transparent,
          borderRadius: BorderRadius.circular(loader ? 30 : borderRadius),
          boxShadow: boxShadow,
        ),
        duration: const Duration(milliseconds: 500),
        height: height.pxH(context),
        width: loader
            ? loaderWidth
            : width == null
                ? 100.percentWidth(context)
                : width!.pxH(context),
        child: loader
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? MyColors.white,
                    ),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    onPressed != null ? MyColors.black0D0D0D : null,
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  // shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                  //   RoundedRectangleBorder(
                  //     borderRadius:
                  //         BorderRadius.circular(loader ? 30.0 : 6),
                  //   ),
                  // ),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      if (prefixIcon != null) ...[
                        prefixIcon!,
                        SizedBox(width: iconSpacing.pxH(context)),
                      ],
                      TextView(
                        loader ? "" : text,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                        style: textStyle ?? myTextStyle.font_12w400,
                      ),
                      if (suffixIcon != null) ...[
                        SizedBox(width: iconSpacing.pxH(context)),
                        suffixIcon!,
                      ]
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
