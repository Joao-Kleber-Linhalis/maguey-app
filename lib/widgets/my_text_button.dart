import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/global_padding.dart';
import 'package:magueyapp/widgets/sized_box.dart';
import 'package:magueyapp/widgets/text_styling.dart';
import 'package:magueyapp/widgets/text_view.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool underlineText;
  final Function() onTap;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final Color? splashColor, underlineColor;
  final double? space;
  final Widget? trailing;
  final double topPadding;
  const MyTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.underlineText = true,
    this.style,
    this.borderRadius,
    this.margin,
    this.splashColor,
    this.space,
    this.trailing,
    this.topPadding = 5,
    this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: margin ?? 4.paddingH(context).copyWith(top: topPadding.pxV(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              text,
              onTap: null,
              splashColor: splashColor,
              borderRadius: borderRadius ?? BorderRadius.circular(10000),
              style: style == null
                  ? TextStyleCustom().font_12w500Black.copyWith(
                        textBaseline: TextBaseline.alphabetic,
                        decoration: underlineText ? TextDecoration.underline : null,
                      )
                  : style!.copyWith(
                      decoration: underlineText ? TextDecoration.underline : null,
                      decorationColor: underlineText ? underlineColor : null,
                    ),
            ),
            if (space != null) space!.hSpace(context),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
