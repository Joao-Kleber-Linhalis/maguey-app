import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/cached_image_widget.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/others/hero_tags.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_details/titled_text_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/review_star_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class ProductDetailsContainer extends StatelessWidget {
  final ProductModel product;
  final double bottomMargin;
  const ProductDetailsContainer({
    super.key,
    required this.product,
    this.bottomMargin = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      padding: 39.paddingV(context),
      margin: bottomMargin.paddingBottom(context),
      color: MyColors.whiteFFFFFF,
      child: Row(
        children: [
          SizedBox(
            height: 353.pxV(context),
            width: (100 - 51.4).percentWidth(context),
            child: Padding(
              padding: 16.paddingLeft(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  TitledTextContainer(
                    title: "Name",
                    value: product.name,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  TitledTextContainer(
                    title: "Manufacture",
                    value: product.manufacturerName,
                  ),
                  const Spacer(),
                  ReviewStarWidget(
                    title: "Reviews",
                    product: product,
                  ),
                  const Spacer(),
                  TitledTextContainer(
                    title: "Price",
                    value: product.price,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Hero(
            tag: ProductHeroTag.productImage(product),
            child: Container(
              height: 353.pxV(context),
              width: 51.4.percentWidth(context),
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.pxH(context)),
                  bottomLeft: Radius.circular(20.pxH(context)),
                ),
              ),
              padding: 14.paddingV(context),
              alignment: Alignment.center,
              child: SizedBox(
                height: 326.pxV(context),
                width: 122.pxH(context),
                // child: Image.asset(
                //   "${MyImages.tempFolderPath}/bottle1.png",
                //   width: 122.pxH(context),
                // ),
                child: MyCachedImageWidget(
                  url: product.imageUrl,
                  centerLoader: true,
                  loaderPadding: EdgeInsets.zero,
                  errorWidth: 40,
                ),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
