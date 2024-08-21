import 'package:flutter/cupertino.dart';

class DSWelcome extends StatelessWidget {
  final String welcomeText;
  final String? pageInfo;
  final bool isDashboardScreen;
  final Widget? pageInfoWidget;
  const DSWelcome({Key? key, required this.welcomeText, this.pageInfo, required this.isDashboardScreen, this.pageInfoWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 280,
      ),
    );
  }
}
