import 'package:flutter/material.dart';
import 'package:magueyapp/widgets/my_text_button.dart';

import '../../design_system/Text/ds_text.dart';

class NoInternetReload extends StatelessWidget {
  final Widget reloadScreen;
  const NoInternetReload({Key? key, required this.reloadScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: DS16DarkPurpleTextBold(
              text: "You Don't have internet connection",
            ),
          ),
          const SizedBox(height: 20),
          MyTextButton(
            text: 'Try again',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => reloadScreen),
              );
            },
          ),
        ],
      ),
    );
  }
}
