import 'package:flutter/material.dart';
import 'package:magueyapp/ui/widgets/snackbars.dart';

import '../../../custom_app_bar.dart';
import '../../../data/event_suggestion_controller.dart';
import '../../../entity/event_suggestion.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/text_styling.dart';
import '../../../widgets/LoaderElevatedButton.dart';

class SuggestEvent extends StatefulWidget {
  const SuggestEvent({Key? key}) : super(key: key);

  @override
  State<SuggestEvent> createState() => _SuggestEventState();
}

class _SuggestEventState extends State<SuggestEvent> {
  bool loader = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController townStateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final keySuggestEvents = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: keySuggestEvents,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: MyColors.black2B2B2B,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  'EVENTS | SUGGEST NEW',
                  style: TextStyleCustom().font_16w500Black.copyWith(
                        color: MyColors.brown97805F,
                        letterSpacing: 1.5,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'SUGGEST NEW EVENT',
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
          'Thank you for suggesting an event, please fill out the form below. This will be reviewed by our team and posted on the app if approved.',
          style: TextStyleCustom().font_14w400.copyWith(
                color: MyColors.yellowE2D7C1,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 15),
        CustomTextFormField(
            hintText: 'Add Title',
            controller: titleController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Event date',
            controller: dateController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a date';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Event address',
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an address';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Event town and state',
            controller: townStateController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a town and state';
              }
              return null;
            }),
        const SizedBox(height: 10),
        CustomTextFormField(
            hintText: 'Event description',
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
            if (!keySuggestEvents.currentState!.validate()) {
              return;
            } else {
              EventSuggestion eventSuggestion = EventSuggestion(
                title: titleController.text,
                date: dateController.text,
                address: addressController.text,
                townState: townStateController.text,
                description: descriptionController.text,
                id: '',
              );
              EventSuggestionController().addEventSuggestion(eventSuggestion);

              ShowSnackBar(context: context).showErrorSnackBar(message: "Event suggestion sent successfully", color: MyColors.greenE3FF0A);
            }
            Navigator.pop(context);
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
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.white,
              )
            : null,
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
      textInputAction: textInputAction,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}
