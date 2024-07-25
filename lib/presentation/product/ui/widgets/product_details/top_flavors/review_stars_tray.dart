import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class ReviewStarTray extends StatelessWidget {
  final double rating;
  final double size;
  const ReviewStarTray({
    super.key,
    required this.rating,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= int.parse(rating.toString()[0]); i++)
          SvgPicture.asset(
            MyIcons.starFilledIcon,
            height: size.pxV(context),
          ),
        if (int.parse(rating.toString()[2]) > 0)
          SvgPicture.asset(
            MyIcons.starPartialFilledIcon,
            height: size.pxV(context),
          ),
        for (int i = 1; i <= 5 - rating; i++)
          SvgPicture.asset(
            MyIcons.starFilledIcon,
            color: MyColors.greyDADADA,
            height: size.pxV(context),
          ),
      ],
    );
  }
}
