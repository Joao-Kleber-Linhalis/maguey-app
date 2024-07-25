import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_appbar.dart';
import 'package:magueyapp/common/widget/profile_icons.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_search_icon.dart';
import 'package:magueyapp/presentation/search/ui/screen/search_screen.dart';
import 'package:magueyapp/presentation/search/view_model/search_route.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

PreferredSize homeAppBar(BuildContext context) {
  return MyAppBar(
    bgColor: MyColors.whiteFFFFFF,
    title: Image.asset(
      MyIcons.brandIcon,
      height: 25.pxV(context),
    ),
    leadingWidget: HomeSearchIcon(
      onSearchTap: () => {
        SearchTapRoute.route = SearchRoute.dashboard,
        context.pushNamed(SearchScreen.route)
      },
    ),
    actionWidgets: const [ProfileIcon()],
  );
}
