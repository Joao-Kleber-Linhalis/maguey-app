import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_horizontal_margin.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/review_stars_tray.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/date_time.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ReviewWidget extends StatelessWidget {
  final ProductReview review;
  final double topSpace;

  const ReviewWidget({
    super.key,
    required this.review,
    this.topSpace = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topSpace.vSpace(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ReviewStarTray(rating: review.rating.toDouble()),
            2.hSpace(context),
            SizedBox(
              height: 16.pxV(context),
              child: TextView(
                review.rating.toString(),
                style: myTextStyle.font_16w500Black,
              ),
            ),
          ],
        ),
        9.vSpace(context),
        TextView(
          review.note,
          style: myTextStyle.font_12w400.copyWith(
            color: MyColors.black0D0D0D,
          ),
          textAlign: TextAlign.justify,
        ),
        12.vSpace(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: MyColors.black0D0D0D,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(MyImages.profileDefaultImage),
              ),
            ),
            5.hSpace(context),
            TextView(
              review.userName,
              style: myTextStyle.font_12w500Black.w700,
            ),
            const Spacer(),
            TextView(
              review.createDate.toDDMMYYYHHMINAM(),
              style: myTextStyle.font_10w400Black,
              padding: 8.paddingRight(context),
            ),
          ],
        ),
        16.vSpace(context),
        const MyHorizontalDivider(),
      ],
    );
  }
}
