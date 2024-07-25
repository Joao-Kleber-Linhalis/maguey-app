import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/appbar_icon_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class EnterReviewWidget extends StatefulWidget {
  final double btmMargin;
  final ReviewState state;
  const EnterReviewWidget({
    super.key,
    this.btmMargin = 16,
    required this.state,
  });

  @override
  State<EnterReviewWidget> createState() => _EnterReviewWidgetState();
}

class _EnterReviewWidgetState extends State<EnterReviewWidget> {
  List<double> reviews = const [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: 16
            .paddingH(context)
            .copyWith(bottom: widget.btmMargin.pxV(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  "Give Review",
                  style: myTextStyle.font_15w700Black,
                ),
                14.vSpace(context),
                Row(
                  children: [
                    ...reviews.map(
                      (val) => MyAppbarIconButton(
                        onTap: () {
                        if (val == widget.state.rating) {
                          widget.state.rating = 0;
                          } else {
                          widget.state.rating = val;
                          }
                          setState(() {});
                        },
                      splashColor: Colors.transparent,
                        icon: MyIcons.starFilledIcon,
                        width: 45,
                        margin: EdgeInsets.zero,
                        borderRadius: 0,
                      iconColor: val <= widget.state.rating!
                          ? null
                          : MyColors.greyDADADA,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextView(
            "${widget.state.rating!}",
              style: myTextStyle.font_28w700Black.copyWith(
                fontSize: 25.pxV(context),
              ),
            ),
          ],
        ),
      
    );
  }
}
