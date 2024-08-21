import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'my_colors.dart';
import 'text_styling.dart';

final myLightThemeData = ThemeData(
  canvasColor: Colors.transparent,
  fontFamily: 'monserrat',
  // primaryColor: MyColors.white,
  // scaffoldBackgroundColor: MyColors.bgPageColor,
  textTheme: GetIt.instance.get<TextStyleCustom>(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontFamily: 'monserrat',
        color: MyColors.whiteFFFFFF,
      ),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: MyColors.black0D0D0D,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 16,
    foregroundColor: MyColors.white,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(
        fontFamily: 'monserrat',
        color: MyColors.whiteFFFFFF,
      ),
      shadowColor: MyColors.transparent,
      backgroundColor: MyColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    ),
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(
  //   secondary: MyColors.themeGreen,
  //
  // ),
);
