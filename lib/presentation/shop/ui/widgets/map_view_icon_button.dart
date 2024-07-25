import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class MapViewIconButton extends StatelessWidget {
  final Function() onTap;
  const MapViewIconButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 42.pxH(context),
        padding: 7.paddingH(context),
        decoration: BoxDecoration(
          color: MyColors.transparent,
          borderRadius: BorderRadius.circular(12.pxH(context)),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          MyIcons.mapViewIcon,
          height: 22.pxH(context),
          width: 20.pxH(context),
        ),
      ),
    );
  }
}
