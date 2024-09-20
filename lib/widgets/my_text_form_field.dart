import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magueyapp/utils/extention.dart';
import 'package:magueyapp/widgets/text_styling.dart';

import '../theme/my_colors.dart';

class MyTextFormField extends StatelessWidget {
  final String title, hintText, initialValue;
  final Color? titleColor, backgroundColor, enabledColor, hintColor, borderColor, filledColor;
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
          TextFormField(
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
            style: inputTextStyle ?? const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: MyColors.black0D0D0D),
            focusNode: focusNode,
            maxLines: maxLines,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff908c00),
                  width: 1.0, // Width of the underline
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff908c00),
                  width: 2.0,
                ),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff908c00),
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff908c00),
                  width: 2.0,
                ),
              ),
              counterText: '',
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixConstraints,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.transparent,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyleCustom().font_16w400Black.copyWith(
                        color: hintColor ?? MyColors.black0D0D0D,
                      ),
              prefix: prefix ??
                  Padding(
                    padding: EdgeInsets.only(left: prefixIcon == null ? 15 : 0),
                  ),
              contentPadding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? MyColors.transparent,
                ),
              ),
            ),
            validator: validator,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: textInputFormater ?? [FilteringTextInputFormatter.singleLineFormatter],
          ),
        ],
      ),
    );
  }
}
