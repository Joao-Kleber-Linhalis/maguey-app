// ignore_for_file: use_build_context_synchronously

import 'package:magueyapp/presentation/product/ui/screen/search_products_screen.dart';
import 'package:magueyapp/presentation/search/redux/actions.dart';
import 'package:magueyapp/presentation/search/redux/search_state.dart';
import 'package:magueyapp/presentation/search/view_model/search_storage_manager.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:redux/redux.dart';

final searchStore = Store<SearchState>(
  searchReducer,
  initialState: SearchState(
    searchQuery: "",
    homeSearchHistory: [],
    productsSearchHistory: [],
  ), // Initial state
);

SearchState searchReducer(SearchState newState, dynamic action) {
  final manager = SearchStorageManager();
  if (action is HomeSearchAction) {
    _handleSearchActionHome(newState, action, manager);
  } else if (action is SearchProductAction) {
    _handleSearchActionProduct(newState, action, manager);
  } else if (action is GetSearchedProductsAction) {
    newState.status = action.status;
    newState.type = action.type;
    newState.searchedProducts = action.searchedProducts;
  }
  return newState;
}

_handleSearchActionProduct(SearchState state, SearchProductAction action,
    SearchStorageManager manager) async {
  if (action.query.isNotEmpty) {
    state.searchQuery = action.query;
    await manager.saveSearchHistory(action.query);
    GlobalContext.currentContext!.pushNamed(SearchProductsScreen.route);
  }
}

_handleSearchActionHome(SearchState state, HomeSearchAction action,
    SearchStorageManager manager) async {
  if (action.query.isNotEmpty) {
    state.searchQuery = action.query;
    await manager.saveSearchHistory(action.query, fromHome: true);
    GlobalContext.currentContext!.pushNamed(SearchProductsScreen.route);
  }
}
