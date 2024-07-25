import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_appbar.dart';
import 'package:magueyapp/common/widget/my_back_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class TitledAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final Function()? onTapOfBackButton;
  final List<Widget>? actionsWidget;
  final Widget? titleWidget, leadingWidget;
  final bool showBackButton;

  const TitledAppBar({
    super.key,
    required this.title,
    this.onTapOfBackButton,
    this.actionsWidget,
    this.titleWidget,
    this.leadingWidget,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: titleWidget ??
          TextView(
            title,
            style: myTextStyle.font_17w700White,
          ),
      leadingWidgetLeftMargin: 12,
      // leadingWidth: 20,
      leadingWidget: showBackButton
          ? MyBackIconButton(
            onTap: onTapOfBackButton ?? () => Navigator.pop(context),
            )
          : leadingWidget,
      actionsRightMargin: 13,
      bgColor: MyColors.black0D0D0D,
      actionWidgets: actionsWidget,
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight.pxH(GlobalContext.currentContext!));
}
