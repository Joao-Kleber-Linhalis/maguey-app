import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_buttons/my_text_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/reviews/review_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ProductReviewsContainer extends StatefulWidget {
  final ProductModel product;
  final double btmMargin;
  final int minimumReviews;
  final Function() onTapOfShowAll;
  final bool isAllReviewsTapped;
  const ProductReviewsContainer({
    super.key,
    required this.product,
    this.btmMargin = 6,
    this.minimumReviews = 1,
    required this.onTapOfShowAll,
    required this.isAllReviewsTapped,
  });

  @override
  State<ProductReviewsContainer> createState() =>
      _ProductReviewsContainerState();
}

class _ProductReviewsContainerState extends State<ProductReviewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      padding: 13.paddingTop(context).copyWith(
            left: 16.pxH(context),
            right: 16.pxH(context),
          ),
      margin: widget.btmMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                "Reviews (${condition()})",
                style: myTextStyle.font_13w700Black.copyWith(
                  fontSize: 18.pxV(context),
                ),
              ),
              if (widget.product.reviews.length > widget.minimumReviews &&
                  widget.product.reviews.isNotEmpty)
                MyTextButton(
                  text: widget.isAllReviewsTapped
                      ? "Show ${widget.minimumReviews} Review Only"
                      : "View All Reviews (${widget.product.reviews.length - widget.minimumReviews} more)",
                  style: myTextStyle.font_12w500Black.w800,
                  onTap: widget.onTapOfShowAll,
                  margin: 8
                      .paddingH(context)
                      .copyWith(top: 8.pxV(context), bottom: 8.pxV(context)),
                ),
            ],
          ),
          if (widget.product.reviews.isEmpty || condition() == 0)
            Align(
              alignment: Alignment.center,
              child: TextView(
                "No Reviews",
                style: myTextStyle.font_12w500Black.copyWith(
                  color: MyColors.grey272424,
                ),
                padding:
                    12.paddingTop(context).copyWith(bottom: 16.pxV(context)),
              ),
            ),
          if (widget.product.reviews.isNotEmpty)
            for (int i = 0; i < condition(); i++)
              ReviewWidget(
                review: widget.product.reviews.reversed.toList()[i],
                topSpace: i == 0 ? 8 : 16,
              ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: condition(),
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) =>
          //         ReviewWidget(review: widget.product.reviews[index]),
          //   ),
          // ),
        ],
      ),
    );
  }

  int condition() {
    if (widget.product.reviews.length >= widget.minimumReviews &&
        !widget.isAllReviewsTapped) {
      return widget.minimumReviews;
    }
    // int len = widget.product.reviews.length;
    // len = 0;
    // return len;
    return widget.product.reviews.length;
  }
}
