import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/review_stars_tray.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ReviewStarWidget extends StatelessWidget {
  final String title;
  final ProductModel product;
  const ReviewStarWidget({
    super.key,
    required this.title,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42.percentWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            title,
            style: myTextStyle.font_12w500.copyWith(
              color: MyColors.black0D0D0D.withOpacity(0.5),
            ),
          ),
          5.vSpace(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ReviewStarTray(rating: product.rating),
              2.hSpace(context),
              SizedBox(
                height: 14,
                child: Text(
                  "${product.rating}",
                  style: myTextStyle.font_16w500Black,
                ),
              ),
              2.hSpace(context),
              Text(
                "(${product.reviews.length})",
                style: myTextStyle.font_12w500Black.copyWith(
                  fontSize: 9.pxV(context),
                  color: MyColors.black0D0D0D.withOpacity(0.5),
                  height: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
