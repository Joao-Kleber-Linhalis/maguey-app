import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class HomepageBanner extends StatelessWidget {
  final double? height;
  final double horizontalMargin;
  final Function()? onBannerTap;
  const HomepageBanner({
    super.key,
    this.height,
    this.horizontalMargin = 24,
    required this.onBannerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: horizontalMargin.paddingH(context),
      width: 100.percentWidth(context),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onBannerTap,
        // child: Image.asset(
        //   MyImages.bannerMapImage,
        //   width: 100.percentWidth(context),
        // ),
        child: Container(
          height: 110,
          width: 100.percentWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
            image: const DecorationImage(
              image: AssetImage(MyImages.bannerMapBGImage),
              fit: BoxFit.cover,
              opacity: 0.65,
            ),
          ),
          padding: 16.paddingAll(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                // "Search bars",
                "Search bars, restaurants and retail stores",
                style: myTextStyle.font_20w800Black.copyWith(
                  height: 1,
                  fontSize: 20.pxV(context),
                  fontWeight: FontWeight.w600,
                  color: MyColors.whiteFFFFFF,
                ),
                maxLine: 2,
              ),
              8.vSpace(context),
              TextView(
                "Enter your city, state, or zip",
                style: myTextStyle.font_10w400Black.copyWith(
                  height: 1,
                  fontSize: 11.pxV(context),
                  fontWeight: FontWeight.w500,
                  color: MyColors.white.withOpacity(0.8),
                ),
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
