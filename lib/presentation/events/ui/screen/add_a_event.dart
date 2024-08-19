import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:magueyapp/theme/my_colors.dart';
import '../../../../theme/text_styling.dart';
import '../../../widgets/custom_app_bar.dart';

final textStyles = TextStyleCustom();

class AddEventPage extends StatelessWidget {
  const AddEventPage({Key? key}) : super(key: key);

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
                'EVENTS | CREATE NEW',
                style: textStyles.font_16w500Black.copyWith(
                  color: MyColors.brown97805F,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Events',
                style: textStyles.font_28w700Black.copyWith(
                  color: MyColors.greenE3FF0A,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildEventCard(),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Add to Calendar',
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Share Event',
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Create New Event',
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'ABE – LOS ANGELES',
                  style: textStyles.font_12w500.copyWith(
                    color: MyColors.greyEBEBEB.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
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
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.white),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            style: const TextStyle(color: Colors.white),
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
              const SizedBox(width: 8),
              Text(
                "FOLLOWING",
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
              hintText: 'Add Event',
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.white),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
