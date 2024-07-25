import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/others/hero_tags.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class ProductFavouriteButton extends StatelessWidget {
  final ProductModel product;
  const ProductFavouriteButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
        height: 42.pxH(context),
        padding: 7.paddingH(context),
        decoration: BoxDecoration(
          color: MyColors.transparent,
          borderRadius: BorderRadius.circular(12.pxH(context)),
        ),
        alignment: Alignment.centerRight,
        child: Hero(
          tag: ProductHeroTag.productFavourite(product),
          child: SvgPicture.asset(
            MyIcons.heartIcon,
            width: 22.pxH(context),
            color: MyColors.whiteFFFFFF,
          ),
        ),
      ),
    );
  }
}
