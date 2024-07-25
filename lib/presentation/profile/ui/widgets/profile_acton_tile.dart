import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ProfileActionTile extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color? color;
  final Function() onTap;
  final bool applyHero;

  const ProfileActionTile({
    super.key,
    required this.text,
    required this.imagePath,
    this.color,
    required this.onTap,
    this.applyHero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.paddingH(context),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Container(
          padding: 12.paddingH(context).copyWith(
                top: 10.pxV(context),
                bottom: 10.pxV(context),
              ),
          height: 46,
          decoration: BoxDecoration(
            color: color ?? MyColors.transparent,
            borderRadius: BorderRadius.circular(5),
            border:
                color == null ? Border.all(color: MyColors.black0D0D0D) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(imagePath),
              10.hSpace(context),
              if (applyHero)
                Hero(
                  tag: "privacy_policy",
                  child: Material(
                    type: MaterialType.transparency,
                    child: title(),
                  ),
                ),
              if (!applyHero) title()
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      text,
      style: myTextStyle.font_12w500Black.textColor(
        color == null ? MyColors.black0D0D0D : MyColors.whiteFFFFFF,
      ),
    );
  }
}
