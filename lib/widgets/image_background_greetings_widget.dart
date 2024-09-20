import 'package:flutter/material.dart';
import 'package:magueyapp/widgets/text_styling.dart';

class ImagedBackgroundGreetingsWidget extends StatelessWidget {
  final String heading;
  final String description;
  const ImagedBackgroundGreetingsWidget({
    super.key,
    required this.description,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          style: TextStyleCustom().font_28w700Black,
        ),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Color(0xff908c00)),
        ),
      ],
    );
  }
}
