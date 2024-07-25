import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class CustomChip extends StatefulWidget {
  final FlavorModel flavor;
  final Function(FlavorModel)? onChipTap;
  final double padding;
  final double fontSize;
  const CustomChip({
    super.key,
    required this.flavor,
    required this.onChipTap,
    this.padding = 4,
    this.fontSize = 10,
  });

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onChipTap != null) {
          widget.onChipTap!(widget.flavor);
          setState(() {});
        }
      },
      borderRadius: BorderRadius.circular(1000),
      child: Container(
        padding:
            widget.padding.paddingAll(context).copyWith(left: 8.pxH(context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: !widget.flavor.selected
              ? MyColors.greyEFEFEF
              : MyColors.black0D0D0D,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              widget.flavor.name,
              style: myTextStyle.font_10w400Black.w500.copyWith(
                fontSize: widget.fontSize,
                color: widget.flavor.selected
                    ? MyColors.whiteFFFFFF
                    : MyColors.black0D0D0D,
              ),
            ),
            Icon(
              Icons.add,
              size: 16,
              color: widget.flavor.selected
                  ? MyColors.whiteFFFFFF
                  : MyColors.black0D0D0D,
            ),
          ],
        ),
      ),
    );
  }
}
