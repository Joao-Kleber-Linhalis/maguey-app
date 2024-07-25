import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class HomeSearchIcon extends StatelessWidget {
  final Function() onSearchTap;
  const HomeSearchIcon({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSearchTap,
      child: Container(
        height: 42.pxH(context),
        width: 42.pxH(context),
        decoration: BoxDecoration(
          color: MyColors.black0D0D0D,
          borderRadius: BorderRadius.circular(12.pxH(context)),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          MyIcons.searchIcon,
          height: 24.pxV(context),
        ),
      ),
    );
  }
}
