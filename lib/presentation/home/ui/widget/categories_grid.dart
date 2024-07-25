import 'package:magueyapp/presentation/home/model/home_category_model.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_grid_container.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class HomeCategoriesGrid extends StatefulWidget {
  final int replications;
  final double horizontalMargin;
  final List<HomeCategoryModel> categories;
  final double verticalSpacing;
  final double childHeight;

  const HomeCategoriesGrid({
    super.key,
    this.replications = 1,
    this.horizontalMargin = 24,
    required this.categories,
    this.verticalSpacing = 8,
    this.childHeight = 190,
  });

  @override
  State<HomeCategoriesGrid> createState() => _HomeCategoriesGridState();
}

class _HomeCategoriesGridState extends State<HomeCategoriesGrid> {
  List<List> data = [];

  makeData2D() {
    for (int i = 0; i < widget.categories.length; i++) {
      var category1 = widget.categories[i];
      dynamic category2;
      if ((i + 1) != widget.categories.length) {
        category2 = widget.categories[++i];
      }
      if (category2 != null) {
        data.add([category1, category2]);
      } else {
        data.add([category1]);
      }
    }
  }

  @override
  void initState() {
    makeData2D();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      // physics: const BouncingScrollPhysics(),
      // padding: widget.horizontalMargin.paddingH(context),
      itemCount: (data.length * widget.replications) + 1,
      itemBuilder: (context, index) {
        if (index < (data.length * widget.replications)) {
          return Padding(
            padding: widget.horizontalMargin.paddingH(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...data[index % data.length].map(
                  (category) => HomeGridContainer(
                    category: category,
                    height: widget.childHeight,
                    margin: widget.verticalSpacing.paddingV(context),
                  ),
                )
              ],
            ),
          );
        }
        return (100.percentHeight(context) -
                (data.length * (widget.childHeight + widget.verticalSpacing)))
            .vSpace(context);
      },
    );
  }
}
