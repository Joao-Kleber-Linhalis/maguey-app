import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_details/titled_text_widget.dart';
import 'package:magueyapp/presentation/shop/model/shop_model.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class ShopInfoWidget extends StatelessWidget {
  final ShopModel shop;
  final int maxLines;
  final double topMargin;
  const ShopInfoWidget({
    super.key,
    required this.shop,
    this.maxLines = 3,
    this.topMargin = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.whiteFFFFFF,
      padding: 20.paddingH(context).copyWith(top: topMargin.pxV(context)),
      child: Column(
        children: [
          _row(
            context,
            [_showVal("Name", shop.name, percentWidth: 89)],
          ),
          _row(
            context,
            [
              _showVal("Contact", shop.contact),
              _showVal("Business Type", shop.shopType),
            ],
          ),
          if (shop.openingTime != null && shop.closingTime != null)
            _row(
              context,
              [
                _showVal("Opening Time", shop.openingTime!),
                _showVal("Closing Time", shop.closingTime!),
            ],
          ),
          _row(
            context,
            [
              _showVal("Area/Town", shop.shopLocation.townName),
              _showVal("Address", shop.shopLocation.address),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    List<Widget> children, [
    double btmMargin = 25,
  ]) {
    return Padding(
      padding: btmMargin.paddingBottom(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _showVal(
    String title,
    String val, {
    double percentWidth = 40,
  }) {
    return TitledTextContainer(
      title: title,
      value: val,
      percentWidth: percentWidth,
      maxLines: maxLines,
    );
  }
}
