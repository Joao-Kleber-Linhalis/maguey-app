import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String route = "privacy_policy";
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitledAppBar(
          title: "",
          titleWidget: Hero(
            tag: "privacy_policy",
            child: Material(
              type: MaterialType.transparency,
              child: TextView(
                "Privacy Policy",
                style: myTextStyle.font_17w700White,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: 18.pxH(context),
              bottom: 11.pxV(context),
              top: 42.pxV(context),
              right: 20.pxH(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                "Privacy Policy",
                style: myTextStyle.font_17w700White.copyWith(
                    fontSize: 28.33.pxV(context), color: MyColors.black0D0D0D),
              ),
              11.vSpace(context),
              TextView(
                """
Duis sagittis congue risus, nec lobortis nisi fermentum auctor. Nunc semper arcu ac vestibulum facilisis. Nulla iaculis suscipit semper. In eu ligula dapibus, tincidunt ex eu, accumsan lacus. Donec sed gravida ante. Ut egestas fringilla elit, id congue massa.

Sed in porttitor magna, vitae viverra mauris. Vivamus feugiat libero eu tortor eleifend efficitur. Nulla quis sagittis ipsum. Curabitur in tortor risus.

Nunc ac sem vitae ex gravida bibendum at eget leo. Aliquam posuere id lorem nec cursus. Praesent ultricies lacus eget auctor lacinia. 

Interdum et malesuada fames ac ante ipsum primis in faucibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam erat volutpat. Morbi varius tortor vel tincidunt fermentum.

Nulla bibendum interdum imperdiet. Pellentesque et condimentum ante. Proin sit amet rhoncus libero. Duis at mattis dolor. Phasellus auctor tempor nibh sit amet consequat. Ut vel odio at tortor molestie consequat.

Sed in porttitor magna, vitae viverra mauris. Vivamus feugiat libero eu tortor eleifend efficitur. Nulla quis sagittis ipsum. Curabitur in tortor risus.

Nunc ac sem vitae ex gravida bibendum at eget leo. Aliquam posuere id lorem nec cursus. Praesent ultricies lacus eget auctor lacinia.
""",
                style: myTextStyle.font_12w500Black,
              ),
            ],
          ),
        ));
  }
}
