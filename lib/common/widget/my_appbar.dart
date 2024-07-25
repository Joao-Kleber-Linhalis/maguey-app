import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final Color bgColor;
  final Widget title;
  final Widget? leadingWidget;
  final double leadingWidth;
  final double leadingWidgetLeftMargin, actionsRightMargin;
  final List<Widget>? actionWidgets;
  final double height;
  const MyAppBar({
    super.key,
    this.bgColor = MyColors.black0D0D0D,
    required this.title,
    this.leadingWidget,
    this.leadingWidgetLeftMargin = 16,
    this.actionsRightMargin = 16,
    this.leadingWidth = 42,
    this.actionWidgets,
    this.height = 42,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      backgroundColor: bgColor,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      flexibleSpace: Container(
        color: bgColor,
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: (leadingWidth + leadingWidgetLeftMargin).pxH(context),
      toolbarHeight: height.pxH(context),
      leading: Padding(
        padding: leadingWidgetLeftMargin.paddingLeft(context),
        child: leadingWidget,
      ),
      actions: actionWidgets == null
          ? null
          : [...actionWidgets!, actionsRightMargin.hSpace(context)],
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
