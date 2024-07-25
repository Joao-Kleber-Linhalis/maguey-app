import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/individual_top_flavor.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class TopFlavoursContainer extends StatelessWidget {
  final ProductModel product;
  final double bottomMargin;
  const TopFlavoursContainer({
    super.key,
    required this.product,
    this.bottomMargin = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      padding: 21.paddingV(context),
      margin: bottomMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextView(
            "Top Flavor Tags",
            style: myTextStyle.font_13w700Black.copyWith(
              fontSize: 18.pxV(context),
            ),
          ),
          12.vSpace(context),
          if (product.topFlavors.isEmpty)
            Align(
              alignment: Alignment.center,
              child: TextView(
                "No Top Flavors Available",
                style: myTextStyle.font_12w500Black.copyWith(
                  color: MyColors.grey272424,
                ),
              ),
            ),
          if (product.topFlavors.isNotEmpty)
            TopFlavors(
              topFlavours: product.topFlavors,
              totalValue: getCumulativeValue(
                product.topFlavors,
                product.topFlavors.length > 3 ? 3 : product.topFlavors.length,
              ),
              color: product.color,
            ),
        ],
      ),
    );
  }

  int getCumulativeValue(List<FlavorModel> data, int len) {
    int sum = 0;
    for (int i = 0; i < len; i++) {
      sum += data[i].value;
    }
    return sum;
  }
}
