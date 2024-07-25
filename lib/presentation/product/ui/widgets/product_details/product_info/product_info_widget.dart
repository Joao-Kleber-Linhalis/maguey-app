import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_info/individual_product_info.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ProductInfoContainer extends StatelessWidget {
  final ProductModel product;
  final double bottomMargin;
  const ProductInfoContainer({
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
            bottom: 10.pxV(context),
          ),
      margin: bottomMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            "Information",
            style: myTextStyle.font_13w700Black.copyWith(
              fontSize: 18.pxV(context),
            ),
          ),
          12.vSpace(context),
          if (product.information.isEmpty)
            Align(
              alignment: Alignment.center,
              child: TextView(
                "No Information Available",
                style: myTextStyle.font_12w500Black.copyWith(
                  color: MyColors.grey272424,
                ),
              ),
            ),
          if (product.information.isNotEmpty)
            ...product.information.map((info) => ProductInfoWidget(info: info)),
        ],
      ),
    );
  }
}
