import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ColorLabel extends StatelessWidget {
  final Color color;
  final String name;
  const ColorLabel({
    super.key,
    required this.color,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        2.hSpace(context),
        TextView(
          name,
          style: myTextStyle.font_12w500.copyWith(
            color: MyColors.black0D0D0D.withOpacity(0.5),
            fontSize: 9.pxV(context),
          ),
        )
      ],
    );
  }
}
