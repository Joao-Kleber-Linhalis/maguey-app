import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/sized_box.dart';
import 'package:magueyapp/widgets/text_styling.dart';
import 'package:magueyapp/widgets/text_view.dart';

import '../theme/my_colors.dart';

class CheckBoxWithText extends StatelessWidget {
  final Function(bool?) onTap;
  final bool value;
  final EdgeInsets margin;
  final String text;

  const CheckBoxWithText({
    super.key,
    required this.onTap,
    this.margin = EdgeInsets.zero,
    this.value = true,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: () => onTap(value),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 14.pxV(context),
              width: 14.pxV(context),
              child: Checkbox(
                value: value,
                splashRadius: 0,
                onChanged: onTap,
                fillColor: MaterialStateProperty.all(
                  value ? MyColors.green658F7B : MyColors.transparent,
                ),
                activeColor: const Color(0xFF908c00),
                focusColor: Color(0xFF908c00),
                checkColor: MyColors.white,
                overlayColor: MaterialStateProperty.all(
                  Color(0xFF908c00),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(4.pxV(context)),
                ),
              ),
            ),
            8.hSpace(context),
            TextView(
              text,
              style: TextStyleCustom().font_14w500Black.copyWith(
                    color: MyColors.black2B2B2B,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
