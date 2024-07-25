import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class TitledTextContainer extends StatelessWidget {
  final String title, value;
  final double percentWidth;
  final int? maxLines;
  const TitledTextContainer({
    super.key,
    required this.title,
    required this.value,
    this.percentWidth = 42,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: percentWidth.percentWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            title,
            style: myTextStyle.font_12w500.copyWith(
              color: MyColors.black0D0D0D.withOpacity(0.5),
            ),
          ),
          TextView(
            value,
            style: myTextStyle.font_16w600Black,
            // maxLine: maxLines,
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
