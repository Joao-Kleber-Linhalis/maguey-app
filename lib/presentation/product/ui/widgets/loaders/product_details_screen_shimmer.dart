import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../product_details/product_details/titled_text_widget.dart';

class ProductDetailsScreenShimmer extends StatelessWidget {
  const ProductDetailsScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
          highlightColor: Colors.grey[300]!, baseColor: Colors.grey[400]!),
      //containersColor: Colors.grey[300],
      child: Column(
        children: [
          Container(
            width: 100.percentWidth(context),
            padding: 39.paddingV(context),
            margin: 6.paddingBottom(context),
            color: MyColors.whiteFFFFFF,
            child: Row(
              children: [
                SizedBox(
                  height: 353.pxV(context),
                  width: (100 - 51.4).percentWidth(context),
                  child: Padding(
                    padding: 16.paddingLeft(context),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(flex: 2),
                        TitledTextContainer(
                          title: "Name",
                          value: "product.name",
                          maxLines: 2,
                        ),
                        Spacer(),
                        TitledTextContainer(
                          title: "Manufacture",
                          value: "product.manufacturerName",
                        ),
                        Spacer(),
                        TitledTextContainer(
                          title: "Price",
                          value: "product.price",
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 353.pxV(context),
                  width: 51.4.percentWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.pxH(context)),
                      bottomLeft: Radius.circular(20.pxH(context)),
                    ),
                  ),
                  child: SizedBox(
                    height: 326.pxV(context),
                    width: 122.pxH(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.pxH(context)),
                        bottomLeft: Radius.circular(20.pxH(context)),
                      ),
                      child: Image.asset(
                        MyImages.bannerImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.percentWidth(context),
            padding: 21.paddingV(context),
            margin: 6.paddingBottom(context),
            color: MyColors.whiteFFFFFF,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextView(
                  "Top Flavor Tags",
                ),
                12.vSpace(context),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 100.percentWidth(context),
              padding: 22.paddingV(context).copyWith(
                    left: 16.pxH(context),
                    right: 16.pxH(context),
                  ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    "Description",
                    style: myTextStyle.font_13w700Black.copyWith(
                      fontSize: 18.pxV(context),
                    ),
                  ),
                  12.vSpace(context),
                  const Align(
                    alignment: Alignment.center,
                    child: TextView("No Description Available"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
