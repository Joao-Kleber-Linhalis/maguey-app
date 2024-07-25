import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/cached_image_widget.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/others/hero_tags.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ProductListTile extends StatelessWidget {
  final ProductModel product;
  final double topMargin, bottomMargin, height, horizontalMargin;
  final double borderRadius;
  final Function(ProductModel) onTap;
  const ProductListTile({
    super.key,
    required this.product,
    this.horizontalMargin = 16,
    this.height = 119,
    this.bottomMargin = 16,
    this.topMargin = 0,
    this.borderRadius = 18,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: horizontalMargin.paddingH(context).copyWith(
            top: topMargin.pxV(context),
            bottom: bottomMargin.pxV(context),
          ),
      height: height.pxV(context),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243, 243, 243, 1),
        borderRadius: BorderRadius.circular(borderRadius.pxV(context)),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(product),
        child: Stack(
          children: [
            Row(
              children: [
                Hero(
                  tag: ProductHeroTag.productImage(product),
                  child: Container(
                    padding: 4.paddingV(context),
                    height: height.pxV(context),
                    width: height.pxV(context),
                    decoration: BoxDecoration(
                      color: product.color,
                      borderRadius:
                          BorderRadius.circular(borderRadius.pxV(context)),
                    ),
                    alignment: Alignment.center,
                    // child: Image.asset(
                    //   "${MyImages.tempFolderPath}/bottle1.png",
                    //   height: (height - 10).pxV(context),
                    // ),
                    child: MyCachedImageWidget(
                      url: product.imageUrl,
                      centerLoader: true,
                      loaderPadding: EdgeInsets.zero,
                      errorWidth: 40,
                    ),
                  ),
                ),
                14.hSpace(context),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // height: 10,
                      width: 48.percentWidth(context),
                      child: TextView(
                        product.name.toUpperCase(),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_20w800Black,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        product.manufacturerName.toUpperCase(),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w600Black,
                      ),
                    ),
                    4.vSpace(context),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        product.description.toUpperCase(),
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w400Black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 35.pxV(context),
                width: 35.pxV(context),
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(borderRadius.pxV(context)),
                    topLeft: Radius.circular(8.pxV(context)),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  product.price,
                  style: myTextStyle.font_10w400Black.copyWith(
                    color: MyColors.whiteFFFFFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
