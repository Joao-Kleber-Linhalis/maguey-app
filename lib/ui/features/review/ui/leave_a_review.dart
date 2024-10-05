import 'dart:io';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magueyapp/data/reviews_controller.dart';
import 'package:magueyapp/entity/review_entity.dart';
import 'package:path/path.dart' as path;

import '../../../../custom_app_bar.dart';
import '../../../../theme/my_colors.dart';
import '../../../../theme/text_styling.dart';
import '../../../../widgets/LoaderElevatedButton.dart';
import '../../../widgets/snackbars.dart';
import '../../brand_select/brand_screen.dart';

class ReviewsPage extends StatefulWidget {
  final String productId;
  const ReviewsPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  bool loader = false;
  final keyReviews = GlobalKey<FormState>();
  double currentRating = 3;
  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  File? _image;
  String? _filename, _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyReviews,
      child: Scaffold(
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
              ],
            ),
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
                _selectProfilePicture(context, '');
              },
              child: Container(
                width: double.infinity, // Match the width of the parent container
                height: 200, // Adjust the height to match your image's placeholder height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  border: Border.all(color: Colors.grey, width: 2), // Border similar to the design
                  color: Colors.black, // Background color of the image placeholder
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Rounded corners for the image
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover, // Ensure the image covers the container nicely
                          width: double.infinity,
                          height: 200,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo, // Icon representing image upload
                            color: Colors.white,
                            size: 40, // Size of the icon
                          ),
                          SizedBox(height: 10),
                          Text(
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
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Add Title',
              filled: true,
              fillColor: Colors.black, // Black background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Radius of 10
                borderSide: BorderSide.none, // No border
              ),
              hintStyle: const TextStyle(color: Colors.white), // White hint text
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
                initialRating: currentRating,
                minRating: 0.0,
                maxRating: 5.0,
                filledColor: MyColors.orangeFD5944,
                emptyColor: MyColors.grey3F3F3F,
                filledIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                emptyIcon: Icons.star_border,
                onChanged: (double rating) {
                  currentRating = rating;
                },
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
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: reviewController,
            maxLines: 4,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Add Review',
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Radius of 10
                borderSide: BorderSide.none, // No border
              ),
              hintStyle: const TextStyle(color: Colors.white), // White hint text
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          MyLoaderElvButton(
            text: "Send review",
            loader: loader,
            onPressed: () async {
              setState(() {
                loader = true;
              });
              if (!keyReviews.currentState!.validate()) {
                ShowSnackBar(context: context).showErrorSnackBar(
                  message: "Please fill in all required fields",
                  color: Colors.red,
                );
                return;
              }

              if (_filename == null || _filename!.isEmpty) {
                ShowSnackBar(context: context).showErrorSnackBar(
                  message: "Please select an image",
                  color: Colors.red,
                );
                return;
              }

              if (titleController.text.trim().isEmpty) {
                ShowSnackBar(context: context).showErrorSnackBar(
                  message: "Title is required",
                  color: Colors.red,
                );
                return;
              }

              if (reviewController.text.trim().isEmpty) {
                ShowSnackBar(context: context).showErrorSnackBar(
                  message: "Review text cannot be empty",
                  color: Colors.red,
                );
                return;
              }

              if (_filename?.isNotEmpty != null && _filename!.isNotEmpty) {
                _imageUrl = await ReviewsController().uploadPhoto(_filename!, _image!, 'reviews');
                setState(() {});
              }

              ReviewEntity eventSuggestion = ReviewEntity(
                id: '',
                imageUrl: _imageUrl ?? '',
                title: titleController.text.trim(),
                rating: currentRating.toInt().toString(),
                reviewText: reviewController.text.trim(),
                productId: widget.productId,
              );

              ReviewsController().addReview(eventSuggestion);
              ShowSnackBar(context: context).showErrorSnackBar(
                message: "Review Added Successfully",
                color: MyColors.greenE3FF0A,
              );
              setState(() {
                loader = false;
              });
              Navigator.pop(context);
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyleCustom().font_14w400,
          ),
        ],
      ),
    );
  }

  Future<void> _selectProfilePicture(BuildContext context, uid) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                selectPhoto(faceDetect: false).then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        _image = value['image'] as File;
                        _filename = value['name'].toString();
                      });
                    }
                  },
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                selectPhoto(source: ImageSource.camera, faceDetect: false).then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        _image = value['image'] as File;
                        _filename = value['name'].toString();
                      });
                    }
                  },
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> selectPhoto({ImageSource source = ImageSource.gallery, required bool faceDetect}) async {
    final picker = ImagePicker();
    final tempImage = await picker.pickImage(source: source);
    if (tempImage != null) {
      return {'image': File(tempImage.path), 'name': path.basename(tempImage.path)};
    }
    return null;
  }
}
