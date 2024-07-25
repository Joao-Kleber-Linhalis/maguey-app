import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class MyBackIconButton extends StatelessWidget {
  final double height, width;
  final Function() onTap;
  const MyBackIconButton({
    super.key,
    required this.onTap,
    this.height = 42,
    this.width = 42,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.pxH(context),
        width: width.pxH(context),
        alignment: Alignment.centerLeft,
        color: MyColors.transparent,
        child: SvgPicture.asset(
          MyIcons.backIcon,
          height: 19.48.pxV(context),
        ),
      ),
    );
  }
}
