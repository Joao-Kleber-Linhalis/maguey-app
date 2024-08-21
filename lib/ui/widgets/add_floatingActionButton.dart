import 'package:flutter/material.dart';

import '../../design_system/colors.dart';

class AddFloatingActionButton extends StatelessWidget {
  final Function() onPressed;
  const AddFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DSColors.addButtonDecoration,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: DSColors.greyScaleWhite,
        ),
      ),
    );
  }
}
