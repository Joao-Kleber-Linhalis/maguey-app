import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extention.dart';

import '../main.dart';
import '../theme/my_colors.dart';

class TextStyleCustom extends TextTheme {
  final TextStyle _textStyle = const TextStyle(
    fontFamily: "montserrat",
    color: MyColors.whiteFFFFFF,
  );

  @override
  TextStyle get titleLarge => _textStyle;

  ///28 font family (Main Heading)
  TextStyle get font_28w700Black => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 28.8.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  /// 20 Font Family

  ///28 font family (Main Heading)
  TextStyle get font_20w800Black => titleLarge.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 20.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  ///32 font family (Main Heading)
  TextStyle get font_32w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32.pxV(globalNavigator.currentContext!),
      );

  ///13 font family (Button Text)
  TextStyle get font_13w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_13w700Black => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  /// 10 font Family
  TextStyle get font_10w400Black => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
        height: 0,
      );
  TextStyle get font_10w600Black => titleLarge.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 10.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
        height: 0,
      );

  /// 12 font Family
  TextStyle get font_12w400 => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 13.pxV(globalNavigator.currentContext!),
      );

  TextStyle get font_13w300 => titleLarge.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 13.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_13w300Black => titleLarge.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 13.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  TextStyle get font_12w500Black => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_12w500 => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_12w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 11.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_12w600Black => titleLarge.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 11.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  ///15 font family (Button Text)
  TextStyle get font_15w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 15.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_15w700Black => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 15.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  ///14 font family (Button Text)
  TextStyle get font_14w400 => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_14w400Black => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_14w500 => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_14w500Black => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );

  ///17 font family (Button Text)
  TextStyle get font_17w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 17.pxV(globalNavigator.currentContext!),
      );
  TextStyle get font_17w400Black => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 17.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_17w700White => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 17.pxV(globalNavigator.currentContext!),
        color: MyColors.white,
      );

  ///58 font family (Button Text)
  TextStyle get font_58w400 => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 58.pxV(globalNavigator.currentContext!),
      );

  /// 16 font family
  TextStyle get font_16w600Black => titleLarge.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_16w400Black => titleLarge.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_16w500Black => titleLarge.copyWith(
        fontWeight: FontWeight.w500,
        height: 0,
        fontSize: 16.pxV(globalNavigator.currentContext!),
        color: MyColors.black0D0D0D,
      );
  TextStyle get font_16w700 => titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 16.pxV(globalNavigator.currentContext!),
      );
}
