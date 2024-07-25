import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magueyapp/common/widget/my_buttons/my_text_button.dart';
import 'package:magueyapp/common/widget/my_text_field.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class CustomSearchBarWithCancelButton extends StatefulWidget {
  final Function(TextEditingController) onSearchSubmitted;
  const CustomSearchBarWithCancelButton({
    super.key,
    required this.onSearchSubmitted,
  });

  @override
  State<CustomSearchBarWithCancelButton> createState() =>
      _CustomSearchBarWithCancelButtonState();
}

class _CustomSearchBarWithCancelButtonState
    extends State<CustomSearchBarWithCancelButton> {
  TextEditingController? searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 72.pxV(context),
      margin: 16.paddingH(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // height: 72.pxV(context),
            // width: 76.percentWidth(context),
            child: MyTextFormField(
              bottomSpace: 0,
              // textFieldHeight: 54.pxV(context),
              prefixConstraints:
                  const BoxConstraints(maxHeight: 17, minWidth: 16),
              hintText: "Find mezcal near you. Enter your zip code",
              prefixIcon: Padding(
                padding: 15.paddingLeft(context),
                child: SvgPicture.asset(
                  MyIcons.searchBoldIcon,
                  //color: MyColors.greyAFAFB7,
                  colorFilter: const ColorFilter.mode(
                      MyColors.greyAFAFB7, BlendMode.srcIn),
                ),
              ),
              prefix: 5.hSpace(context),
              hintStyle: myTextStyle.font_14w500Black.w600
                  .textColor(MyColors.greyAFAFB7),
              borderRadius: 17,
              controller: searchController,
              onFieldSubmitted: (val) =>
                  widget.onSearchSubmitted(searchController!),
            ),
          ),
          8.hSpace(context),
          Padding(
            padding: 10.paddingTop(context),
            child: MyTextButton(
              topPadding: 5,
              text: "Cancel",
              onTap: () => context.pop(),
              style: myTextStyle.font_13w700Black.w600,
              underlineText: false,
            ),
          ),
        ],
      ),
    );
  }
}
