import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/appbar_icon_button.dart';
import 'package:magueyapp/common/widget/my_appbar.dart';
import 'package:magueyapp/common/widget/profile_icons.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

PreferredSize shopDetailsAppbar(BuildContext context) {
  return MyAppBar(
    bgColor: MyColors.whiteFFFFFF,
    title: Image.asset(
      MyIcons.brandIcon,
      height: 25.pxV(context),
    ),
    leadingWidget: MyAppbarIconButton(
      onTap: () => context.pop(),
      icon: MyIcons.backIconLight,
      width: 24,
      bgColor: MyColors.black0D0D0D,
    ),
    actionWidgets: const [ProfileIcon()],
  );
}
