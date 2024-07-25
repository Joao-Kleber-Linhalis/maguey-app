import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/profile/ui/screen/profile_screen.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

class ProfileIcon extends StatelessWidget {
  final Widget? image;
  const ProfileIcon({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(ProfileScreen.route),
      child: Container(
        height: 42.pxH(context),
        width: 42.pxH(context),
        decoration: BoxDecoration(
          color: MyColors.whiteFFFFFF,
          // color: MyColors.black0D0D0D,
          borderRadius: BorderRadius.circular(12.pxH(context)),
          border: Border.all(width: 0.5),
        ),
        alignment: Alignment.center,
        child: Hero(
          tag: "profile",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.pxH(context)),
            child: image ??
                Image.asset(
                  MyImages.profileDefaultImage,
                  fit: BoxFit.contain,
                ),
          ),
        ),
      ),
    );
  }
}
