import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';

class MyHorizontalDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final EdgeInsets? margin;
  const MyHorizontalDivider({
    super.key,
    this.height = 1,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      color: color ?? MyColors.black0D0D0D.withOpacity(0.05),
    );
  }
}
