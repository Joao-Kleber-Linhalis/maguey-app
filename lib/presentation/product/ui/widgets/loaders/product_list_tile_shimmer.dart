import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListTileShimmer extends StatelessWidget {
  final double topMargin, bottomMargin, height, horizontalMargin;
  final double borderRadius;
  const ProductListTileShimmer({
    super.key,
    this.horizontalMargin = 16,
    this.height = 119,
    this.bottomMargin = 0,
    this.topMargin = 16,
    this.borderRadius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
          highlightColor: Colors.grey[300]!, baseColor: Colors.grey[400]!),
      child: Container(
        margin: horizontalMargin.paddingH(context).copyWith(
              top: topMargin.pxV(context),
              bottom: bottomMargin.pxV(context),
            ),
        height: height.pxV(context),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius.pxV(context)),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: height.pxV(context),
                  width: height.pxV(context),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius:
                        BorderRadius.circular(borderRadius.pxV(context)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(borderRadius.pxV(context)),
                    child: Image.asset(
                      MyImages.bannerImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                14.hSpace(context),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // height: 10,
                      width: 48.percentWidth(context),
                      child: TextView(
                        "product.name.toUpperCase()",
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_20w800Black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        "product.manufacturerName.toUpperCase()",
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w600Black,
                      ),
                    ),
                    4.vSpace(context),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        "product.description.toUpperCase()",
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w400Black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 35.pxV(context),
                width: 35.pxV(context),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(borderRadius.pxV(context)),
                    topLeft: Radius.circular(8.pxV(context)),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "abc",
                  style: myTextStyle.font_10w400Black.copyWith(
                    color: MyColors.whiteFFFFFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
