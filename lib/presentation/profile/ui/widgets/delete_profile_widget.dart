import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_bottom_sheet.dart';
import 'package:magueyapp/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

void deleteAccount(BuildContext context, Function(bool) onTap) {
  CustomBottomSheet.openBottomSheet(context,
      child: DeleteProfileWidget(onTap: onTap));
}

class DeleteProfileWidget extends StatefulWidget {
  final Function(bool) onTap;
  const DeleteProfileWidget({
    super.key,
    required this.onTap,
  });

  @override
  State<DeleteProfileWidget> createState() => _DeleteProfileWidgetState();
}

class _DeleteProfileWidgetState extends State<DeleteProfileWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextView(
          "Delete your account",
          style: myTextStyle.font_20w800Black.w600,
        ),
        30.vSpace(context),
        MyTextFormField(
          margin: 16.paddingH(context),
          hintText: "Enter Your Email",
          hintStyle: myTextStyle.font_15w700.w500.textColor(
            MyColors.grey8F8F8F,
          ),
          prefixIcon: const Icon(Icons.email, color: MyColors.grey8F8F8F),
          filledColor: MyColors.transparent,
          borderColor: MyColors.grey8F8F8F,
        ),
        35.vSpace(context),
        Padding(
          padding: 32.paddingLeft(context).copyWith(right: 40.pxH(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19,
                height: 19,
                child: Checkbox(
                  value: isChecked,
                  activeColor: MyColors.black0D0D0D,
                  onChanged: (val) => setState(() => isChecked = !isChecked),
                ),
              ),
              TextView(
                "Aliquam erat volutpat. Morbi varius tortor vel tincidunt fermentum, Aliquam erat volutpat. Morbi varius.",
                style: myTextStyle.font_12w500Black,
                width: 271.pxH(context),
                onTap: () => setState(() => isChecked = !isChecked),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.percentHeight(context)),
        MyLoaderElvButton(
          padding: 16.paddingH(context),
          borderRadius: 1000,
          loader: false,
          text: "Delete Account",
          textStyle: myTextStyle.font_20w800Black.copyWith(
            color: MyColors.whiteFFFFFF,
            fontSize: 18.pxV(context),
          ),
          boxShadow: [
            BoxShadow(
              color: MyColors.black0D0D0D.withOpacity(0.5),
              offset: const Offset(1, 1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          onPressed: () => widget.onTap(isChecked),
        ),
        SizedBox(height: 7.percentHeight(context)),
      ],
    );
  }
}
