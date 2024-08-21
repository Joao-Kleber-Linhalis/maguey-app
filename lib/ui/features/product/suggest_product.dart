import 'package:flutter/material.dart';
import 'package:magueyapp/data/product_suggestion_controller.dart';
import 'package:magueyapp/entity/product_suggestion_entity.dart';
import 'package:magueyapp/ui/widgets/snackbars.dart';

import '../../../custom_app_bar.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/text_styling.dart';
import '../../../widgets/LoaderElevatedButton.dart';

class SuggestAProduct extends StatefulWidget {
  const SuggestAProduct({Key? key}) : super(key: key);

  @override
  State<SuggestAProduct> createState() => _SuggestAProductState();
}

class _SuggestAProductState extends State<SuggestAProduct> {
  bool loader = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final keySuggestProducts = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: keySuggestProducts,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: MyColors.black2B2B2B,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  'PRODUCTS | SUGGEST NEW',
                  style: TextStyleCustom().font_16w500Black.copyWith(
                        color: MyColors.brown97805F,
                        letterSpacing: 1.5,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'SUGGEST NEW PRODUCT',
                  style: TextStyleCustom().font_28w700Black.copyWith(
                        color: MyColors.greenE3FF0A,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                _buildEventCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thank you for suggesting an product, please fill out the form below. This will be reviewed by our team and posted on the app if approved.',
          style: TextStyleCustom().font_14w400.copyWith(
                color: MyColors.yellowE2D7C1,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
            hintText: 'Product name',
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Product brand',
            controller: brandController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a brand';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Product description',
            controller: descriptionController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            }),
        const SizedBox(height: 16),
        MyLoaderElvButton(
          text: "Send Suggestion",
          loader: loader,
          onPressed: () {
            if (!keySuggestProducts.currentState!.validate()) {
              return;
            } else {
              ProductSuggestion productSuggestion = ProductSuggestion(
                name: nameController.text,
                brand: brandController.text,
                description: descriptionController.text,
                id: '',
              );
              ProductSuggestionController().addProductSuggestion(productSuggestion);

              ShowSnackBar(context: context).showErrorSnackBar(message: "Product suggestion sent successfully", color: MyColors.greenE3FF0A);
            }
            Navigator.pop(context);
          },
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: TextStyleCustom().font_14w400,
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
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
      validator: validator,
    );
  }
}
