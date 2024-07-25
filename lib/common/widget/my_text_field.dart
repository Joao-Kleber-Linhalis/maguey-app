import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class MyTextFormField extends StatelessWidget {
  final String title, hintText, initialValue;
  final Color? titleColor,
      backgroundColor,
      enabledColor,
      hintColor,
      borderColor,
      filledColor;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? titleBtnOnTap;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? textInputFormater;
  final bool? focusColorEnable, obscure;
  final bool? readOnly, showTitle, isShowTitleBtn;
  final double focusedBorderWidth, textFieldHeight;
  final double? bottomSpace;
  final int maxLines;
  final EdgeInsets margin;
  final Widget? prefix;
  // final TextStyle? textStyleCustom;
  final TextStyle? inputTextStyle, hintStyle;
  final double borderRadius;
  final BoxConstraints? prefixConstraints;

  const MyTextFormField({
    Key? key,
    this.title = '',
    this.titleColor,
    this.initialValue = '',
    this.backgroundColor,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.prefix,
    this.maxLength,
    this.onTap,
    this.keyboardType,
    this.filledColor,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.textInputFormater,
    this.suffixIcon,
    this.focusColorEnable = false,
    this.obscure = false,
    this.readOnly = false,
    this.showTitle = true,
    this.enabledColor,
    this.hintColor,
    this.focusedBorderWidth = 1.0,
    this.borderRadius = 5,
    this.titleBtnOnTap,
    this.isShowTitleBtn,
    this.margin = EdgeInsets.zero,
    this.textFieldHeight = 48,
    this.bottomSpace,
    this.maxLines = 1,
    this.hintStyle,
    this.prefixConstraints,
    this.inputTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin.copyWith(bottom: bottomSpace?.pxV(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTitle ?? true)
            Row(
              children: [
                TextView(
                  title,
                  maxLine: 3,
                  style: myTextStyle.font_13w300.copyWith(
                    color: titleColor ?? MyColors.green667085,
                  ),
                ),
                // if (isShowTitleBtn ?? false)
                //   GestureDetector(
                //     onTap: titleBtnOnTap,
                //     child: SvgIconCustom(
                // svgIcon: MyIcons.warringIcon,
                // iconColor: MyThemeColor.iconColor(context),
                //     iconSize: 15,
                //   ),
                // ),
              ],
            ),
          SizedBox(
            height: textFieldHeight.pxH(context),
            child: TextFormField(
              onTap: onTap,
              readOnly: readOnly ?? false,
              obscureText: obscure ?? false,
              onFieldSubmitted: onFieldSubmitted,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: textInputAction,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLength: maxLength,
              controller: controller,
              style: inputTextStyle ??
                  myTextStyle.font_15w700.w400
                      .copyWith(color: MyColors.black0D0D0D),
              focusNode: focusNode,
              maxLines: maxLines,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? MyColors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                counterText: '',
                prefixIcon: prefixIcon,
                prefixIconConstraints: prefixConstraints,
                suffixIcon: suffixIcon,
                filled: true,
                errorStyle: myTextStyle.font_13w300Black
                    .copyWith(color: MyColors.redD85229),
                fillColor: filledColor ?? MyColors.greyEAECF0,
                hintText: hintText,
                hintStyle: hintStyle ??
                    myTextStyle.font_14w500.copyWith(
                      color: hintColor ?? MyColors.black0D0D0D,
                      // MyThemeColor.textColor(
                      //   context,
                      //   darkColor: MyColors.white600,
                      //   lightColor: MyColors.white400,
                      // ),
                    ),
                prefix: prefix ??
                    Padding(
                      padding:
                          EdgeInsets.only(left: prefixIcon == null ? 15 : 0),
                    ),
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColorEnable!
                        ? MyColors.black0D0D0D
                        // MyThemeColor.textFieldBorderColor(
                        //     context,
                        //     lightColor: MyColors.black,
                        //     darkColor: MyColors.white,
                        //   )
                        : MyColors.transparent,
                    width: focusedBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              validator: validator,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: textInputFormater ??
                  [FilteringTextInputFormatter.singleLineFormatter],
            ),
          ),
        ],
      ),
    );
  }
}
