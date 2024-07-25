import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/ui/screen/shop_details_screen.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class MapViewShopTapContainer extends StatelessWidget {
  final double height, width;
  final Function() onClose;
  const MapViewShopTapContainer({
    super.key,
    required this.height,
    required this.width,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.percentHeight(context),
      width: 100.percentWidth(context),
      margin: 16.paddingH(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.whiteFFFFFF,
      ),
      child: InkWell(
        onTap: () => context.pushNamed(ShopDetailsScreen.route),
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              right: 5.pxH(context),
              top: 5.pxV(context),
              child: InkWell(
                onTap: onClose,
                child: SvgPicture.asset(
                  MyIcons.closeCircleButton,
                  // height: 24,
                  width: 36.pxH(context),
                ),
              ),
            ),
            Positioned(
              child: StoreBuilder<ShopState>(
                builder: (context, shopStore) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    34.vSpace(context),
                    TextView(
                      shopStore.state.selectedShop!.shopType,
                      style: myTextStyle.font_12w500Black.copyWith(fontSize: 8),
                      padding: 24.paddingLeft(context),
                    ),
                    8.vSpace(context),
                    TextView(
                      shopStore.state.selectedShop!.name,
                      padding: 24.paddingLeft(context),
                      style: myTextStyle.font_16w500Black.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    15.vSpace(context),
                    TextView(
                      shopStore.state.selectedShop!.contact,
                      style: myTextStyle.font_12w500Black.copyWith(fontSize: 8),
                      padding: 24.paddingLeft(context),
                    ),
                    10.vSpace(context),
                    Container(
                      height: 125.pxV(context),
                      margin: 16.paddingH(context),
                      width: width,
                      decoration: BoxDecoration(
                        color: MyColors.black0D0D0D,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Image.asset(
                            shopStore.state.selectedShop!.isRetail
                                ? MyImages.retailImage
                                : MyImages.barImage,
                            // "${MyImages.tempFolderPath}/event.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
