import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class MyFilterWidget extends StatelessWidget {
  final String value;
  final Function(String) onTap;
  const MyFilterWidget({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value),
      child: Column(
        children: [
          20.vSpace(context),
          Container(
            padding: 16.paddingH(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  value,
                  style: myTextStyle.font_15w700Black.w600,
                ),
                SvgPicture.asset(MyIcons.arrowForwardIcon),
              ],
            ),
          ),
          17.vSpace(context),
          Container(
            height: 1,
            width: 100.percentWidth(context),
            margin: 16.paddingH(context),
            color: MyColors.greyE0E0E0,
          ),
        ],
      ),
    );
  }
}
