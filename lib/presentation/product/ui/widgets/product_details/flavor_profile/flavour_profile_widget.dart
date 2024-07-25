import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/flavor_profile/colored_label_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class FlavourProfileContainer extends StatelessWidget {
  final ProductModel product;
  final double bottomMargin;
  const FlavourProfileContainer({
    super.key,
    required this.product,
    this.bottomMargin = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      padding: 18.paddingTop(context).copyWith(
            left: 16.pxH(context),
            right: 16.pxH(context),
            bottom: 12.pxV(context),
          ),
      margin: bottomMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            "Flavor Profile",
            style: myTextStyle.font_13w700Black.copyWith(
              fontSize: 18.pxV(context),
            ),
          ),
          12.vSpace(context),
          if (product.topFlavors.isEmpty)
            Align(
              alignment: Alignment.center,
              child: TextView(
                "No Flavors Available",
                style: myTextStyle.font_12w500Black.copyWith(
                  color: MyColors.grey272424,
                ),
              ),
            ),
          if (product.topFlavors.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    17.vSpace(context),
                    ...(product.topFlavors.length > 5
                            ? product.topFlavors.sublist(0, 5)
                            : product.topFlavors)
                        .map(
                      (data) => TextView(
                        data.name,
                        padding: 21.paddingBottom(context),
                        style: myTextStyle.font_12w500Black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ColorLabel(
                      color: MyColors.black0D0D0D,
                      name: "High",
                    ),
                    34.vSpace(context),
                    ColorLabel(
                      color: MyColors.black0D0D0D.withOpacity(0.6),
                      name: "Medium",
                    ),
                    34.vSpace(context),
                    ColorLabel(
                      color: MyColors.black0D0D0D.withOpacity(0.3),
                      name: "Low",
                    ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}
