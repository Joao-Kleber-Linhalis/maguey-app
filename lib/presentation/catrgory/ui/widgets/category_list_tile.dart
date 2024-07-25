import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/model/category_model.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class CategoryListTile extends StatelessWidget {
  final CategoryModel category;
  final double height, imageHeight;
  final double topPadding, bottomPadding, horizontalPadding;
  final double topMargin, bottomMargin, horizontalMargin;
  final double borderRadius;
  final Function(CategoryModel) onTap;
  const CategoryListTile({
    super.key,
    required this.category,
    required this.onTap,
    this.height = 119,
    this.horizontalPadding = 0,
    this.bottomPadding = 0,
    this.topPadding = 0,
    this.horizontalMargin = 16,
    this.topMargin = 0,
    this.bottomMargin = 10,
    this.borderRadius = 18,
    this.imageHeight = 109,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.pxV(context),
      width: 100.percentWidth(context),
      margin: horizontalMargin.paddingH(context).copyWith(
            top: topMargin.pxV(context),
            bottom: bottomMargin.pxV(context),
          ),
      padding: horizontalPadding.paddingH(context).copyWith(
            top: topPadding.pxV(context),
            bottom: bottomPadding.pxV(context),
          ),
      decoration: BoxDecoration(
        // color: category.lightColor,
        color: const Color.fromARGB(255, 227, 245, 242),
        borderRadius: BorderRadius.circular(borderRadius.pxH(context)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius.pxH(context)),
        splashColor: Colors.transparent,
        onTap: () => onTap(category),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    // Container With dark Color
                    Container(
                      width: 52.pxH(context),
                      decoration: BoxDecoration(
                        color: const Color(0xff33766a), // category.darkColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius.pxH(context)),
                          bottomLeft:
                              Radius.circular(borderRadius.pxH(context)),
                        ),
                      ),
                    ),
                    // 36.hSpace(context),
                    16.hSpace(context),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Added Sizedbox because the font has extra vertical margin
                // by default and I had to control it...
                SizedBox(
                  height: category.titleFontSize.pxH(context),
                  width: 65.percentWidth(context),
                  child: TextView(
                    category.title,
                    style: myTextStyle.font_58w400.copyWith(
                      color: const Color(0xff33766a), // category.darkColor,
                      fontFamily: getIt<String>(instanceName: "f2"),
                      fontSize: category.titleFontSize.pxH(context),
                      height: 0,
                    ),
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                4.vSpace(context),
                Container(
                  height: 23.pxH(context),
                  width: 81.pxH(context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff33766a), // category.darkColor,
                    ),
                  ),
                  child: TextView(
                    "View More",
                    style: myTextStyle.font_12w400.copyWith(
                      color: const Color(0xff33766a), // category.darkColor,
                      fontSize: 11.pxH(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
