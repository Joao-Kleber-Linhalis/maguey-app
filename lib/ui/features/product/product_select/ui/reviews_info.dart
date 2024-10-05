import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/data/reviews_controller.dart';

import '../../../../../entity/review_entity.dart';
import '../../../../../theme/my_colors.dart';
import '../../../brand_select/brand_screen.dart';

class ReviewsInfo extends StatefulWidget {
  final String productId;
  const ReviewsInfo({super.key, required this.productId});

  @override
  State<ReviewsInfo> createState() => _ReviewsInfoState();
}

class _ReviewsInfoState extends State<ReviewsInfo> {
  final ReviewsController reviewService = ReviewsController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StreamBuilder<List<ReviewEntity>>(
        stream: reviewService.streamAllReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var reviews = snapshot.data!.where((review) => review.productId == widget.productId).toList();
            double reviewsTotal = 0;
            for (var review in reviews) {
              reviewsTotal += double.parse(review.rating);
            }
            reviewsTotal = reviewsTotal / reviews.length;

            if (reviews.isEmpty) {
              return Row(
                children: [
                  IgnorePointer(
                    child: AnimatedRatingStars(
                      initialRating: 0,
                      minRating: 0.0,
                      maxRating: 5.0,
                      filledColor: MyColors.orangeFD5944,
                      emptyColor: MyColors.grey3F3F3F,
                      filledIcon: Icons.star,
                      halfFilledIcon: Icons.star_half,
                      emptyIcon: Icons.star,
                      onChanged: (double rating) {},
                      displayRatingValue: true,
                      interactiveTooltips: true,
                      customFilledIcon: Icons.star,
                      customHalfFilledIcon: Icons.star_half,
                      customEmptyIcon: Icons.star,
                      starSize: 20.0,
                      animationDuration: const Duration(milliseconds: 100),
                      animationCurve: Curves.easeInOut,
                      readOnly: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'REVIEWS (0)',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.greyEBEBEB.withOpacity(0.2),
                      decoration: TextDecoration.underline,
                      decorationColor: MyColors.greyEBEBEB.withOpacity(0.2),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: 1,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    IgnorePointer(
                      ignoring: true,
                      child: AnimatedRatingStars(
                        initialRating: reviewsTotal,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: MyColors.orangeFD5944,
                        emptyColor: MyColors.grey3F3F3F,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star,
                        onChanged: (double rating) {},
                        displayRatingValue: true,
                        interactiveTooltips: true,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star,
                        starSize: 20.0,
                        animationDuration: const Duration(milliseconds: 100),
                        animationCurve: Curves.easeInOut,
                        readOnly: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'REVIEWS (${reviews.length})',
                      style: textStyles.font_12w500.copyWith(
                        color: MyColors.greyEBEBEB.withOpacity(0.2),
                        decoration: TextDecoration.underline,
                        decorationColor: MyColors.greyEBEBEB.withOpacity(0.2),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Row(
              children: [
                IgnorePointer(
                  child: AnimatedRatingStars(
                    initialRating: 0,
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: MyColors.orangeFD5944,
                    emptyColor: MyColors.grey3F3F3F,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star,
                    onChanged: (double rating) {},
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star_half,
                    customEmptyIcon: Icons.star,
                    starSize: 20.0,
                    animationDuration: const Duration(milliseconds: 100),
                    animationCurve: Curves.easeInOut,
                    readOnly: false,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'REVIEWS (0)',
                  style: textStyles.font_12w500.copyWith(
                    color: MyColors.greyEBEBEB.withOpacity(0.2),
                    decoration: TextDecoration.underline,
                    decorationColor: MyColors.greyEBEBEB.withOpacity(0.2),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
