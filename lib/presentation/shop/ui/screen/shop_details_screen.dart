import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/description/product_description_container.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shop_details_appbar.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shop_image_widget.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/shop_info_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class ShopDetailsScreen extends StatelessWidget {
  static const String route = "shop_details";
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyF5F5F5,
      appBar: shopDetailsAppbar(context),
      body: StoreBuilder<ShopState>(
        builder: (context, store) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ShopImageWidget(
              image: Image.asset(
                // "${MyImages.tempFolderPath}/event.png",
                store.state.selectedShop!.isRetail
                    ? MyImages.retailImage
                    : MyImages.barImage,
                fit: BoxFit.fill,
              ),
              shop: store.state.selectedShop!,
            ),
            ShopInfoWidget(shop: store.state.selectedShop!),
            6.vSpace(context),
            DescriptionContainer(
              description: store.state.selectedShop!.description,
            ),
          ],
        ),
      ),
    );
  }
}
