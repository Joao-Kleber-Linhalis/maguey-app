import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class DSStandardText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  const DSStandardText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class DSStandardGreyText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  const DSStandardGreyText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.textGreyColor,
        textAlign: textAlign);
  }
}

class DSStandardDarkPurpleText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  const DSStandardDarkPurpleText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.secondaryActionAccentDeepPurple);
  }
}

class DSStandardLightPurpleText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  const DSStandardLightPurpleText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.primaryActionState1);
  }
}

class DSGreenText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  const DSGreenText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.positiveAccentGreen);
  }
}

class DSYellowText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  const DSYellowText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.accent1Yellow);
  }
}

class DSWhiteText extends StatelessWidget {
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const DSWhiteText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      this.overflow,
      this.textAlign
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: DSColors.greyScaleWhite,
        overflow: overflow,
        textAlign: textAlign,
        );
  }
}

class DS10GreyText extends StatelessWidget {
  final String text;
  const DS10GreyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
        text: text, fontSize: 11, fontWeight: FontWeight.w600);
  }
}

class DS11GreyText extends StatelessWidget {
  final String text;
  const DS11GreyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
        text: text, fontSize: 11, fontWeight: FontWeight.w500);
  }
}

class DS12GreyText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const DS12GreyText({Key? key, required this.text, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
      text: text,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      textAlign: textAlign,
    );
  }
}

class DS12GreyTextLight extends StatelessWidget {
  final String text;
  const DS12GreyTextLight({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
        text: text, fontSize: 12, fontWeight: FontWeight.w400);
  }
}

class DS13GreyTextLight extends StatelessWidget {
  final String text;
  const DS13GreyTextLight({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
        text: text, fontSize: 12, fontWeight: FontWeight.w500);
  }
}

class DS14GreyText extends StatelessWidget {
  final String text;
  const DS14GreyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}

class DS16GreyText extends StatelessWidget {
  final String text;
  const DS16GreyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
      text: text,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
}

class DS20TextFieldGrey extends StatelessWidget {
  final String text;
  const DS20TextFieldGrey({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardGreyText(
        text: text, fontSize: 12, fontWeight: FontWeight.bold);
  }
}

class DSButtonTextWhite extends StatelessWidget {
  final String buttonText;
  const DSButtonTextWhite({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
      text: buttonText,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: DSColors.greyScaleWhite,
    );
  }
}

class DSButtonTextBlack extends StatelessWidget {
  final String buttonText;
  const DSButtonTextBlack({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardText(
      text: buttonText,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: DSColors.greyscaleBlack,
    );
  }
}

class DSDarkPurpleTitle extends StatelessWidget {
  final String text;
  const DSDarkPurpleTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 24, fontWeight: FontWeight.bold);
  }
}

class DS12DarkPurpleText extends StatelessWidget {
  final String text;
  const DS12DarkPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.w500);
  }
}

class DS13DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS13DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 13, fontWeight: FontWeight.w500);
  }
}

class DS14DarkPurpleText extends StatelessWidget {
  final String text;
  const DS14DarkPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.w500);
  }
}

class DS16DarkPurpleText extends StatelessWidget {
  final String text;
  const DS16DarkPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 16, fontWeight: FontWeight.w500);
  }
}

class DS18DarkPurpleText extends StatelessWidget {
  final String text;
  const DS18DarkPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.w500);
  }
}

class DS20DarkPurpleText extends StatelessWidget {
  final String text;
  const DS20DarkPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.w500);
  }
}

class DS12DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS12DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.bold);
  }
}

class DS14DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS14DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.bold);
  }
}

class DS16DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS16DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 16, fontWeight: FontWeight.bold);
  }
}

class DS18DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS18DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.bold);
  }
}

class DS20DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS20DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.bold);
  }
}

class DS24DarkPurpleTextBold extends StatelessWidget {
  final String text;
  const DS24DarkPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 24, fontWeight: FontWeight.bold);
  }
}

class DS12DarkPurpleTextLight extends StatelessWidget {
  final String text;
  const DS12DarkPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.w400);
  }
}

class DS14DarkPurpleTextLight extends StatelessWidget {
  final String text;
  const DS14DarkPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.w400);
  }
}

class DS16DarkPurpleLight extends StatelessWidget {
  final String text;
  const DS16DarkPurpleLight({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 16, fontWeight: FontWeight.w400);
  }
}

class DS18DarkPurpleTextLight extends StatelessWidget {
  final String text;
  const DS18DarkPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.w400);
  }
}

class DS20DarkPurpleTextLight extends StatelessWidget {
  final String text;
  const DS20DarkPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardDarkPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.w400);
  }
}

class DSLightPurpleTitle extends StatelessWidget {
  final String text;
  const DSLightPurpleTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 24, fontWeight: FontWeight.bold);
  }
}

class DS12LightPurpleText extends StatelessWidget {
  final String text;
  const DS12LightPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.w500);
  }
}

class DS13LightPurpleTextBold extends StatelessWidget {
  final String text;
  const DS13LightPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 13, fontWeight: FontWeight.w500);
  }
}

class DS14LightPurpleText extends StatelessWidget {
  final String text;
  const DS14LightPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.w500);
  }
}

class DS16LightPurpleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  const DS16LightPurpleText({Key? key, required this.text, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
      text: text,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: 16,
    );
  }
}

class DS18LightPurpleText extends StatelessWidget {
  final String text;
  const DS18LightPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.w500);
  }
}

class DS20LightPurpleText extends StatelessWidget {
  final String text;
  const DS20LightPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.w500);
  }
}

class DS24LightPurpleText extends StatelessWidget {
  final String text;
  const DS24LightPurpleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 24, fontWeight: FontWeight.w500);
  }
}

class DS12LightPurpleBold extends StatelessWidget {
  final String text;
  const DS12LightPurpleBold({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.bold);
  }
}

class DS14LightPurpleTextBold extends StatelessWidget {
  final String text;
  const DS14LightPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.bold);
  }
}

class DS16LightPurpleTextBold extends StatelessWidget {
  final String text;
  const DS16LightPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 16, fontWeight: FontWeight.bold);
  }
}

class DS18LightPurpleTextBold extends StatelessWidget {
  final String text;
  const DS18LightPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.bold);
  }
}

class DS20LightPurpleTextBold extends StatelessWidget {
  final String text;
  const DS20LightPurpleTextBold({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.bold);
  }
}

class DS12LightPurpleTextLight extends StatelessWidget {
  final String text;
  const DS12LightPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 12, fontWeight: FontWeight.w400);
  }
}

class DS14LightPurpleTextLight extends StatelessWidget {
  final String text;
  const DS14LightPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 14, fontWeight: FontWeight.w400);
  }
}

class DS16LightPurpleTextLight extends StatelessWidget {
  final String text;
  const DS16LightPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 16, fontWeight: FontWeight.w400);
  }
}

class DS18LightPurpleTextLight extends StatelessWidget {
  final String text;
  const DS18LightPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 18, fontWeight: FontWeight.w400);
  }
}

class DS20LightPurpleTextLight extends StatelessWidget {
  final String text;
  const DS20LightPurpleTextLight({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSStandardLightPurpleText(
        text: text, fontSize: 20, fontWeight: FontWeight.w400);
  }
}

class DS20GreenText extends StatelessWidget {
  final String text;
  const DS20GreenText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSGreenText(text: text, fontSize: 20, fontWeight: FontWeight.normal);
  }
}

class DS16YellowText extends StatelessWidget {
  final String text;
  const DS16YellowText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSYellowText(text: text, fontSize: 16, fontWeight: FontWeight.bold);
  }
}

class DS14YellowText extends StatelessWidget {
  final String text;
  const DS14YellowText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSYellowText(text: text, fontSize: 14, fontWeight: FontWeight.bold);
  }
}

class DS16WhiteText extends StatelessWidget {
  final String text;
  const DS16WhiteText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSWhiteText(text: text, fontSize: 16, fontWeight: FontWeight.bold);
  }
}

class DS14WhiteText extends StatelessWidget {
  final String text;
  const DS14WhiteText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSWhiteText(text: text, fontSize: 14, fontWeight: FontWeight.bold);
  }
}

class DS12WhiteTextBold extends StatelessWidget {
  final String text;
  const DS12WhiteTextBold({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSWhiteText(text: text, fontSize: 12, fontWeight: FontWeight.bold);
  }
}

class DSWhiteTitle extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const DSWhiteTitle({Key? key, required this.text, this.overflow, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSWhiteText(text: text, fontSize: 40, fontWeight: FontWeight.bold, overflow: overflow, textAlign: textAlign );
  }
}
