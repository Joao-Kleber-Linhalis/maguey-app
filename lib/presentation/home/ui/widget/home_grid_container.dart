import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/cached_image_widget.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/home/model/home_category_model.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:redux/redux.dart';

class HomeGridContainer extends StatelessWidget {
  final double height, width;
  final HomeCategoryModel category;
  final EdgeInsets margin;
  const HomeGridContainer({
    super.key,
    required this.category,
    this.height = 190,
    this.width = 145,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.pxV(context),
      width: width.pxH(context),
      alignment: Alignment.center,
      // color: Colors.red,
      margin: margin,
      child: GestureDetector(
        onTap: () {
          Store<ProductState> prod =
              StoreProvider.of<ProductState>(context, listen: false);
          category.onTapOfCategory(context, prod);
        },
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height.pxV(context),
              width: width.pxH(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.pxH(context)),
                border: Border.all(
                  width: 5.pxH(context),
                  color: const Color(0xff33766a), // category.color,
                  // color: category.color,
                  // strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: width.pxH(context),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.pxH(context)),
                  bottomRight: Radius.circular(32.pxH(context)),
                ),
                child: Image.asset(
                  MyImages.homeContainerImage,
                  color: const Color(0xff33766a), // category.color,
                ),
              ),
            ),
            TextView(
              category.title,
              padding: 12.paddingLeft(context).copyWith(top: 24.pxV(context)),
              style: myTextStyle.font_17w700.copyWith(
                color: const Color(0xff33766a), // category.color,
                fontSize: 16.pxV(context),
              ),
              width: 20.percentWidth(context),
              maxLine: 2,
            ),
            Positioned(
              bottom: 10,
              right: 5,
              height: (height - 50).pxV(context),
              child: SizedBox(
                child: MyCachedImageWidget(url: category.imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
