import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/appbar_icon_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_filter_tap.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class EventsMapSearchbar extends StatelessWidget {
  final Function()? onListTap;
  const EventsMapSearchbar({
    super.key,
    required this.onListTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: MediaQuery.of(context).viewPadding.top + 16,
      width: 100.percentWidth(context),
      child: Container(
        height: 56.pxV(context),
        margin: 24.paddingH(context),
        decoration: BoxDecoration(
          color: MyColors.whiteFFFFFF,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: 8.paddingAll(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70.percentWidth(context),
              child: InkWell(
                onTap: () => onEventFilterTap(context),
                child: Row(
                  children: [
                    MyAppbarIconButton(
                      onTap: () {},
                      icon: MyIcons.searchIcon,
                      bgColor: MyColors.black0D0D0D,
                      borderRadius: 200,
                      width: 20,
                      height: null,
                      margin: 8.paddingAll(context),
                    ),
                    8.hSpace(context),
                    TextView(
                      "Search Here...",
                      style: 14.txt(context),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            MyAppbarIconButton(
              onTap: () {
                if (onListTap != null) onListTap!();
              },
              icon: "",
              bgColor: MyColors.black0D0D0D,
              borderRadius: 200,
              width: 20,
              height: 38,
              margin: 8.paddingAll(context),
              child: const Icon(
                Icons.list,
                size: 20,
                color: MyColors.whiteFFFFFF,
              ),
            ),
            // Padding(
            //   padding: 24.paddingH(context),
            //   child: SearchBar(
            //     hintText: "Search here",
            //     hintStyle: MaterialStateProperty.all(
            //       myTextStyle.font_12w500
            //           .textColor(MyColors.black0D0D0D.withOpacity(0.3))
            //           .copyWith(fontSize: 12),
            //     ),
            //     leading: MyAppbarIconButton(
            //       onTap: () {},
            //       icon: MyIcons.searchIcon,
            //       bgColor: MyColors.black0D0D0D,
            //       borderRadius: 200,
            //       width: 20,
            //       height: null,
            //       margin: 8.paddingAll(context),
            //     ),
            //     backgroundColor: MaterialStateProperty.all(MyColors.greyFDFDFD),
            //     trailing: [
            //       MyAppbarIconButton(
            //         onTap: () {
            //           if (onListTap != null) onListTap!();
            //         },
            //         icon: "",
            //         bgColor: MyColors.black0D0D0D,
            //         borderRadius: 200,
            //         width: 20,
            //         height: null,
            //         margin: 8.paddingAll(context),
            //         child: const Icon(
            //           Icons.list,
            //           size: 20,
            //           color: MyColors.whiteFFFFFF,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
