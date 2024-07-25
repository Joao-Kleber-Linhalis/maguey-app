import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/home/redux/home_actions.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_banner.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      backgroundColor: MyColors.whiteFFFFFF,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 42.pxH(context),
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      collapsedHeight: 42.pxH(context),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        expandedTitleScale: 1,
        title: Transform.translate(
          offset: const Offset(-40, 0),
          child: Text(
            "Categories",
            style: myTextStyle.font_15w700Black,
          ),
        ),
        background: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextView(
                "Find Mezcal and Agave Spirits Near You",
                padding: 16.paddingLeft(context),
                style: myTextStyle.font_28w700Black,
              ),
            ),
            const SizedBox(height: 20),
            StoreBuilder<HomeState>(
              builder: (context, store) => HomepageBanner(
                onBannerTap: () => store.dispatch(
                  NavigationAction(index: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
