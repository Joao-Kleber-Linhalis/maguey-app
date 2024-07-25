import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/cached_image_widget.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/others/hero_tags.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/string.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ReviewProductInfo extends StatelessWidget {
  final ProductModel product;
  final Alignment? alignment;
  const ReviewProductInfo({
    super.key,
    required this.product,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: ProductHeroTag.productImage(product),
            child: MyCachedImageWidget(url: product.imageUrl,width: 300.pxH(context),height:300.pxV(context)),
          ),
          7.vSpace(context),
          TextView(
            product.name.toUpperCase(),
            style: myTextStyle.font_20w800Black,
            width: 70.percentWidth(context),
            textAlign: TextAlign.center,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
          ),
          TextView(
            product.manufacturerName.capitalizeInitials(),
            style: myTextStyle.font_10w600Black.textColor(MyColors.redD85229),
            width: 70.percentWidth(context),
            textAlign: TextAlign.center,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
