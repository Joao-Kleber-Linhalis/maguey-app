import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class InstructionWidget extends StatefulWidget {
  final Function() onTermsAndPoliciesTap, onPrivacyPolicyTap;
  const InstructionWidget({
    super.key,
    required this.onPrivacyPolicyTap,
    required this.onTermsAndPoliciesTap,
  });

  @override
  State<InstructionWidget> createState() => _InstructionWidgetState();
}

class _InstructionWidgetState extends State<InstructionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: 46.paddingH(context),
            child: Text.rich(
              TextSpan(
                text: "By signing up, you agree to our ",
                children: [
                  TextSpan(
                    text: "Term of service",
                    style: myTextStyle.font_12w700
                        .copyWith(color: MyColors.green658F7B),
                    onEnter: (event) {},
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
          Padding(
            padding: 46.paddingH(context),
            child: Text.rich(
              TextSpan(
                text: "& acknowledge that our ",
                children: [
                  TextSpan(
                    text: "Privacy Policy",
                    style: myTextStyle.font_12w700
                        .copyWith(color: MyColors.green658F7B),
                  ),
                  const TextSpan(text: "  applies"),
                ],
              ),
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
          Padding(
            padding: 46.paddingH(context),
            child: Text(
              " to you.",
              textAlign: TextAlign.center,
              style: myTextStyle.font_12w500Black,
            ),
          ),
        ],
      ),
    );
  }
}
