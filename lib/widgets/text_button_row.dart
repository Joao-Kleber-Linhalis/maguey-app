import 'package:flutter/material.dart';
import 'package:magueyapp/widgets/global_padding.dart';
import 'package:magueyapp/widgets/text_view.dart';

class TextButtonRow extends StatelessWidget {
  final String message, buttonText;
  final Function() onTap;
  const TextButtonRow({
    super.key,
    required this.buttonText,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
          message,
          style: const TextStyle(fontSize: 16, color: Color(0xff838383)),
        ),
        TextView(
          buttonText,
          style: const TextStyle(fontSize: 16, color: Color(0xff908c00), fontWeight: FontWeight.w600),
          padding: 4.paddingH(context),
          onTap: onTap,
        )
      ],
    );
  }
}
