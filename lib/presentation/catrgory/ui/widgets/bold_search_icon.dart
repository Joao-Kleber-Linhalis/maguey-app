import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class BoldSearchIcon extends StatelessWidget {
  final Function() onSearchTap;
  const BoldSearchIcon({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onSearchTap,
      child: Container(
        height: 42.pxH(context),
        padding: 7.paddingH(context),
        decoration: BoxDecoration(
          color: MyColors.transparent,
          borderRadius: BorderRadius.circular(12.pxH(context)),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          MyIcons.searchBoldIcon,
          height: 20.pxH(context),
          width: 20.pxH(context),
        ),
      ),
    );
  }
}
