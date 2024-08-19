import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:magueyapp/theme/my_colors.dart';
import '../../../../theme/text_styling.dart';
import '../../widgets/custom_app_bar.dart';

final textStyles = TextStyleCustom();

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: MyColors.black2B2B2B,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'MEZCAL | AGUA MAGICA | REVIEWS',
                style: textStyles.font_16w500Black.copyWith(
                  color: MyColors.brown97805F,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Reviews',
                style: textStyles.font_28w700Black.copyWith(
                  color: MyColors.greenE3FF0A,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildReviewCard(),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Add to Favorites',
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Leave A Review',
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle image picker
              },
              child: Container(
                width:
                    double.infinity, // Match the width of the parent container
                height:
                    200, // Adjust the height to match your image's placeholder height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  border: Border.all(
                      color: Colors.grey,
                      width: 2), // Border similar to the design
                  color:
                      Colors.black, // Background color of the image placeholder
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo, // Icon representing image upload
                      color: Colors.white,
                      size: 40, // Size of the icon
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Add Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Text size adjusted to match design
                        fontWeight: FontWeight.bold, // Bold to match the design
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Add Title',
              filled: true,
              fillColor: Colors.black, // Black background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Radius of 10
                borderSide: BorderSide.none, // No border
              ),
              hintStyle:
                  const TextStyle(color: Colors.white), // White hint text
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            style: const TextStyle(color: Colors.white), // White text
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AnimatedRatingStars(
                initialRating: 4,
                minRating: 0.0,
                maxRating: 5.0,
                filledColor: MyColors.orangeFD5944,
                emptyColor: MyColors.grey3F3F3F,
                filledIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                emptyIcon: Icons.star_border,
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
              const SizedBox(width: 8),
              Text(
                "REVIEWS (200+)",
                style: textStyles.font_12w500.copyWith(
                  color: MyColors.greyEBEBEB.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add Review',
              filled: true,
              fillColor: Colors.black, // Black background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Radius of 10
                borderSide: BorderSide.none, // No border
              ),
              hintStyle:
                  const TextStyle(color: Colors.white), // White hint text
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            style: const TextStyle(color: Colors.white), // White text
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'ABE – LOS ANGELES',
            style: textStyles.font_12w500.copyWith(
              color: MyColors.greyEBEBEB.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
