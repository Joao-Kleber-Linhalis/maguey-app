import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/shop/redux/reducer.dart';
import 'package:magueyapp/presentation/shop/redux/shop_actions.dart';
import 'package:magueyapp/presentation/shop/ui/screen/shop_details_screen.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/presentation/shop/others/hero_tags.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/string.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ShopListTile extends StatelessWidget {
  final ShopModel shop;
  final double topMargin, bottomMargin, height, horizontalMargin;
  final double borderRadius;

  const ShopListTile({
    super.key,
    required this.shop,
    this.horizontalMargin = 16,
    this.height = 119,
    this.bottomMargin = 16,
    this.topMargin = 0,
    this.borderRadius = 18,
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
        onTap: () {
          shopStore.dispatch(OnShopMarkerTapAction(shop: shop, show: false));
          context.pushNamed(ShopDetailsScreen.route);
        },
        child: Stack(
          children: [
            Row(
              children: [
                Hero(
                  tag: ShopHeroTags.shopImage(shop),
                  child: Container(
                    height: height.pxV(context),
                    width: height.pxV(context),
                    decoration: BoxDecoration(
                      color: MyColors.black0D0D0D,
                      borderRadius:
                          BorderRadius.circular(borderRadius.pxV(context)),
                    ),
                    // alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(borderRadius.pxV(context)),
                      child: Image.asset(
                        // "${MyImages.tempFolderPath}/event.png",
                        shop.isRetail
                            ? MyImages.retailImage
                            : MyImages.barImage,
                        // height: (height - 10).pxV(context),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                14.hSpace(context),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    16.vSpace(context),
                    SizedBox(
                      // height: 20,
                      width: 40.percentWidth(context),
                      child: TextView(
                        shop.name.toUpperCase(),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_20w800Black,
                      ),
                    ),
                    SizedBox(
                      width: 40.percentWidth(context),
                      child: TextView(
                        shop.shopLocation.townName.toUpperCase(),
                        maxLine: 2,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w600Black,
                      ),
                    ),
                    4.vSpace(context),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        shop.description.capitalizeInitials(),
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
              top: 0,
              right: 0,
              child: Padding(
                padding:
                    12.paddingRight(context).copyWith(top: 12.pxV(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (shop.openingTime != null) ...[
                      TextView(
                        "Opens at",
                        style: myTextStyle.font_10w400Black.copyWith(
                          fontSize: 8.pxV(context),
                        ),
                      ),
                      TextView(
                        shop.openingTime!,
                        style: myTextStyle.font_10w400Black.w600,
                      ),
                    ],
                    if (shop.closingTime != null) ...[
                      TextView(
                        "Closes at",
                        style: myTextStyle.font_10w400Black.copyWith(
                          fontSize: 8.pxV(context),
                        ),
                      ),
                      TextView(
                        shop.closingTime!,
                        style: myTextStyle.font_10w400Black.w600,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
