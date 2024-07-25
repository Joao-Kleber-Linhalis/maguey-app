import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class DescriptionContainer extends StatelessWidget {
  final String description;
  final double bottomMargin;
  const DescriptionContainer({
    super.key,
    required this.description,
    this.bottomMargin = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      padding: 22.paddingV(context).copyWith(
            left: 16.pxH(context),
            right: 16.pxH(context),
          ),
      margin: bottomMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            "Description",
            style: myTextStyle.font_13w700Black.copyWith(
              fontSize: 18.pxV(context),
            ),
          ),
          12.vSpace(context),
          Align(
            alignment:
                description.isEmpty
                ? Alignment.center
                : Alignment.centerLeft,
            child: TextView(
              description.isEmpty
                  ? "No Description Available"
                  : description,
              style: myTextStyle.font_12w500Black.copyWith(
                color: MyColors.grey272424,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
