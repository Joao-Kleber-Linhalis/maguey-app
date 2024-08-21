import 'package:flutter/cupertino.dart';

import 'Text/ds_text.dart';
import 'colors.dart';

class DSToggleTab extends StatelessWidget {
  final double fontSize;
  final int index;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSelectedTextColorDarkPink;

  const DSToggleTab({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.fontSize,
    this.isSelectedTextColorDarkPink = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? DSColors.greyScaleWhite : null,
          ),
          child: Center(
            child: isSelected
                ? isSelectedTextColorDarkPink
                    ? DSStandardDarkPurpleText(
                        text: text,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      )
                    : DSStandardLightPurpleText(
                        text: text,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      )
                : DSStandardText(
                    text: text,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: DSColors.secondaryActionState3,
                  ),
          ),
        ),
      ),
    );
  }
}

class DSToggleBar extends StatelessWidget {
  final List<Widget> toggleTabs;
  final bool includeDecoration;
  const DSToggleBar(
      {Key? key, required this.toggleTabs, required this.includeDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: includeDecoration ? DSColors.buttonBoxDecoration : null,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...toggleTabs,
          ],
        ),
      ),
    );
  }
}
