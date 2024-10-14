import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/data/reviews_controller.dart';

import '../../../../../entity/review_entity.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../theme/my_colors.dart';
import '../../../brand_select/brand_screen.dart';

class ReviewsList extends StatefulWidget {
  final String productId;
  const ReviewsList({super.key, required this.productId});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  final ReviewsController reviewService = ReviewsController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 10000),
      child: StreamBuilder<List<ReviewEntity>>(
        stream: reviewService.streamAllReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var reviews = snapshot.data!.where((review) => review.productId == widget.productId).toList();

            if (reviews.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'No reviews found for this product',
                    textAlign: TextAlign.start,
                    style: textStyles.font_16w700.copyWith(
                      color: MyColors.yellowE2D7C1,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: reviews.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ReviewEntity review = reviews[index];
                return Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(review.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.title,
                                textAlign: TextAlign.start,
                                style: textStyles.font_16w700.copyWith(
                                  color: MyColors.yellowE2D7C1,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.reviewText,
                                textAlign: TextAlign.start,
                                style: textStyles.font_12w400.copyWith(
                                  color: MyColors.yellowE2D7C1,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              IgnorePointer(
                                child: AnimatedRatingStars(
                                  initialRating: double.parse(review.rating),
                                  minRating: 0.0,
                                  maxRating: 5.0,
                                  filledColor: MyColors.orangeFD5944,
                                  emptyColor: MyColors.grey3F3F3F,
                                  filledIcon: Icons.star,
                                  halfFilledIcon: Icons.star_half,
                                  emptyIcon: Icons.star_border,
                                  displayRatingValue: true,
                                  interactiveTooltips: true,
                                  customFilledIcon: Icons.star,
                                  customHalfFilledIcon: Icons.star_half,
                                  customEmptyIcon: Icons.star,
                                  starSize: 18.0,
                                  animationDuration: const Duration(milliseconds: 100),
                                  animationCurve: Curves.easeInOut,
                                  readOnly: false,
                                  onChanged: (double) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (review.userId == UserProvider().currentUser.id)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await showDialogDelete(context, review.id);
                          },
                        ),
                      ),
                  ],
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'No reviews found for this product',
                  textAlign: TextAlign.start,
                  style: textStyles.font_16w700.copyWith(
                    color: MyColors.yellowE2D7C1,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> showDialogDelete(
    BuildContext context,
    String reviewId,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsOverflowButtonSpacing: 2,
        actionsOverflowDirection: VerticalDirection.down,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text("Are you sure you want to delete this review?", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20))),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('No', textAlign: TextAlign.center)),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
            onPressed: () async {
              ReviewsController().deleteReview(reviewId);
              Navigator.pop(context);
            },
            child: Text('Yes', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
