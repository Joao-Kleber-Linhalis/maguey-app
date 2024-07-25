import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/review/ui/widgets/custom_chip_tile.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class WrappingChipWidget extends StatelessWidget {
  final List<FlavorModel> flavors;
  final Function(FlavorModel)? onTap;
  const WrappingChipWidget({
    super.key,
    required this.flavors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      margin: 16.paddingH(context),
      child: flavors.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: TextView(
                "No Flavors Available",
                style: myTextStyle.font_12w500Black.copyWith(
                  color: MyColors.grey272424,
                ),
              ),
            )
          : Wrap(
              runAlignment: WrapAlignment.spaceAround,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 9.pxH(context),
              runSpacing: 7.0.pxV(context),
              children: [
                ...flavors.map(
                  (flavor) => CustomChip(flavor: flavor, onChipTap: onTap),
                ),
              ],
            ),
    );
  }
}
