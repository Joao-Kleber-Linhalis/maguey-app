import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/search/redux/actions.dart';
import 'package:magueyapp/presentation/search/redux/reducer.dart';
import 'package:magueyapp/presentation/search/redux/search_state.dart';
import 'package:magueyapp/presentation/search/ui/widgets/recent_search_widget.dart';
import 'package:magueyapp/presentation/search/ui/widgets/search_bar_with_cancel_button.dart';
import 'package:magueyapp/presentation/search/view_model/search_route.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class SearchScreen extends StatefulWidget {
  static const String route = "search_screen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBarWithCancelButton(
              onSearchSubmitted: (controller) => onTapOfSearch("", controller),
            ),
            16.vSpace(context),
            searchHistory.isEmpty
                ? Center(
                    child: TextView(
                      "No Search History",
                      style: myTextStyle.font_14w500Black,
                    ),
                  )
                : Expanded(
                    child: StoreBuilder<SearchState>(builder: (context, state) {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: 16.paddingTop(context),
                        children: searchHistory
                            .map(
                              (filter) => RecentSearchWidget(
                                value: filter,
                                onSearchTap: (val) => onTapOfSearch(val, null),
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }

  List<String> get searchHistory =>
      SearchTapRoute.route == SearchRoute.dashboard
          ? searchStore.state.homeSearchHistory
          : searchStore.state.productsSearchHistory;

  void onTapOfSearch(String value, TextEditingController? controller) {
    String query = value.isEmpty ? controller!.text : value;
    switch (SearchTapRoute.route) {
      case SearchRoute.dashboard:
        StoreProvider.of<SearchState>(context)
            .dispatch(HomeSearchAction(query));
        break;
      case SearchRoute.product:
        StoreProvider.of<SearchState>(context)
            .dispatch(SearchProductAction(query));
        break;
      default:
        StoreProvider.of<SearchState>(context)
            .dispatch(HomeSearchAction(query));
        return;
    }
    // if (controller != null) controller.clear();
  }
}
