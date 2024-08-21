import 'package:flutter/material.dart';

import 'colors.dart';

class DSLoadingIndicator extends StatefulWidget {
  const DSLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<DSLoadingIndicator> createState() => _DSLoadingIndicatorState();
}

class _DSLoadingIndicatorState extends State<DSLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(
          color: DSColors.primaryTextBlack,
        ),
      ),
    );
  }
}
