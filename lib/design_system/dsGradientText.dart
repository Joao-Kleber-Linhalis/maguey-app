import 'package:flutter/cupertino.dart';

class DSGradientText extends StatelessWidget {
  final Widget title;
  const DSGradientText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF4F184F), Color(0xFFA54FA5)],
        ).createShader(bounds);
      },
      child: title,
    );
  }
}
