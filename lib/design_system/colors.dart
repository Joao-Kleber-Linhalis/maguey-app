import 'package:flutter/material.dart';

class DSColors {
  static const Color primaryActionState1 = Color(0xFFA054A0);
  static const Color secondaryActionAccentDeepPurple = Color(0xFF502A50);
  static const Color accent1Yellow = Color(0xFFFFE663);
  static const Color accentOrange = Color(0xFFFFAC4B);
  static const Color positiveAccentGreen = Color(0xFF6CC79C);
  static const Color negativeAccentsRed = Color(0xFFF77988);
  static const Color primaryTextBlack = Color(0xFF272627);
  static const Color secondaryActionState3 = Color(0xFFE5D3E5);

  static const Color greyScaleDarkGrey = Color(0xFF727172);
  static const Color greyScaleMediumDarkGrey = Color(0xFF989798);

  static const Color greyScaleMediumGrey = Color(0xFFC2C1C2);
  static const Color greyScaleLightGrey = Color(0xFFF4F3F4);

  static const Color greyScaleWhite = Color(0xFFFFFFFF);
  static const Color accentsErrorRed = Color(0xFFDB2345);

  static const Color blueSnackBarColor = Color(0xFF7277ED);
  static const Color transparent = Colors.transparent;

  static const Color accentsIncome = Color(0xFF3A3D7E);
  static const Color accentsExpenses = Color(0xFF7277E0);

  static const Color textGreyColor = Color(0xFF888888);
  static const Color greyColorTextFieldCard = Color(0xFFF8F7F7);
  static const Color textingControllerColo = Color(0xFFF6F6F6);
  static const Color darkGreyColor = Color(0xFFCCCCCC);

  static const Color categoriesClothingPersonalCare = Color(0xFFEF8296);
  static const Color categoriesEntertainment = Color(0xFFEF9C82);
  static const Color categoriesFood = Color(0xFFEFD182);
  static const Color categoriesHealthcare = Color(0xFFD3EF82);
  static const Color categoriesHouseholdSupplies = Color(0xFF82EF93);
  static const Color categoriesKids = Color(0xFF6CC79C);
  static const Color categoriesPersonalDevelopment = Color(0xFF82B4EF);
  static const Color categoriesPets = Color(0xFF8B82EF);
  static const Color categoriesTransportation = Color(0xFFB282EF);
  static const Color categoriesOther = Color(0xFFEF82DE);
  static const Color greyscaleBlack = Color(0xFF272627);

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFA054A0), Color(0xFF502A50)],
  );

  static Decoration addButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(50.0),
    border: Border.all(
      color: const Color(0xFFA54FA5),
      width: 1.0,
    ),
    gradient: const LinearGradient(
      colors: [
        Color(0xFF763176),
        Color(0xFFA54FA5),
        Color(0xFFC57690),
      ],
      stops: [0.3199, 0.7605, 0.9832],
      transform: GradientRotation(
        0,
      ),
    ),
    boxShadow: const [
      BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 8.0,
        spreadRadius: 0.0,
        color: Color.fromRGBO(79, 24, 79, 0.32),
      ),
    ],
  );
  static Decoration bottomNavBarAppBarsDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFC67690),
        Color(0xFFA54FA5),
        Color(0xFF7E367E),
      ],
      stops: [0.0065, 0.4413, 0.9993],
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(160, 84, 160, 0.16),
        offset: Offset(0, 4),
        blurRadius: 8,
        spreadRadius: -2,
      ),
    ],
  );

  static Decoration buttonBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: const Color(0xFF8E478E),
      width: 1,
    ),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF763176),
        Color(0xFFA54FA5),
        Color(0xFFC57690),
      ],
      stops: [0.0, 0.64, 1.0],
    ),
  );
  // color: const Color(0xffede7ec),
  static Decoration buttonDeactivatedBoxDecoration = BoxDecoration(
    color: const Color(0xffede7ec),
    borderRadius: BorderRadius.circular(30),
  );
}
