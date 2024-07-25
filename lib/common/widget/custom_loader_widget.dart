import 'package:flutter/cupertino.dart';

class CustomLoaderWidget extends StatelessWidget {
  final double radius;
  const CustomLoaderWidget({
    super.key,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius,
      ),
    );
  }
}
