import 'package:flutter/cupertino.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class MyImageLoader extends StatelessWidget {
  final ImageChunkEvent? event;
  final String? text;
  final double width;
  final EdgeInsets? loaderPadding;
  const MyImageLoader({
    super.key,
    this.event,
    this.text,
    this.width = 60,
    this.loaderPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: event != null
          ? CircularProgressIndicator(
              backgroundColor: MyColors.black0D0D0D,
              value: double.parse(
                (event!.cumulativeBytesLoaded / event!.expectedTotalBytes!)
                    .toString(),
              ),
            )
          // : TextView(
          //     text!,
          //     style:
          //         myTextStyle.font_10w400Black.textColor(MyColors.whiteFFFFFF),
          //     width: 40,
          //     textAlign: TextAlign.center,
          //   ),
          : Padding(
              padding: loaderPadding ?? 20.paddingTop(context),
              child: const CupertinoActivityIndicator(
                color: MyColors.white,
                radius: 10,
              ),
            ),
    );
  }
}
