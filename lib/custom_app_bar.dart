import 'package:flutter/material.dart';

import 'theme/my_colors.dart';
import 'theme/my_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDivider;
  const CustomAppBar({super.key, this.showDivider = true});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          GestureDetector(
            onTap: () {
              /*Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false, // This condition removes all routes from the stack
              );*/
            },
            child: Image.asset(MyIcons.brandIcon, height: 50),
          ),
        ],
      ),
      toolbarHeight: 100,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: MyColors.green908C00,
      clipBehavior: Clip.hardEdge,
      centerTitle: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: preferredSize,
              child: const Divider(
                color: Color(0xFF908C00),
                thickness: 0.5,
                height: 30,
              ),
            )
          : null,
    );
  }
}
