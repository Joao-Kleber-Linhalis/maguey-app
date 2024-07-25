import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ImagedBackgroundGreetingsWidget extends StatelessWidget {
  final String imageUrl;
  final String heading;
  final String description;
  final double height;
  const ImagedBackgroundGreetingsWidget({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.heading,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.percentHeight(context),
      width: 100.percentWidth(context),
      child: Stack(
        children: [
          Positioned(
            width: 100.percentWidth(context),
            height: height.percentHeight(context),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
              width: 100.percentWidth(context),
              height: height.percentWidth(context),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              65.vSpace(context),
              TextView(
                heading,
                padding: 21.paddingLeft(context),
                style: myTextStyle.font_32w700,
              ),
              TextView(
                description,
                padding: 21.paddingLeft(context),
                width: 251.pxH(context),
                style: myTextStyle.font_13w300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
