import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class MyAppbarIconButton extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final Color? iconColor, splashColor, bgColor;
  final double width, borderRadius;
  final double? height;
  final EdgeInsets? margin;
  final Widget? child;

  const MyAppbarIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.margin,
    this.iconColor = MyColors.whiteFFFFFF,
    this.bgColor,
    this.width = 22,
    this.splashColor,
    this.borderRadius = 12,
    this.height = 42,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        height: height?.pxH(context),
        padding: margin ?? 7.paddingH(context),
        decoration: BoxDecoration(
          color: bgColor ?? MyColors.transparent,
          borderRadius: BorderRadius.circular(borderRadius.pxH(context)),
        ),
        alignment: Alignment.centerRight,
        child: child ??
            SvgPicture.asset(
          icon,
          width: width.pxH(context),
          color: iconColor,
        ),
      ),
    );
  }
}
