import 'package:magueyapp/presentation/search/redux/reducer.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class SearchStorageManager {
  SharedPrefsManager pref = getIt<SharedPrefsManager>();
  String prodS = "product_search_history";
  String homeS = "home_search_history";

  Future<void> saveSearchHistory(String qurey, {bool fromHome = false}) async {
    String key = fromHome ? homeS : prodS;
    final list = pref.getListOfString(key);
    if (list.length == 5) {
      list.removeAt(0);
      if (!list.contains(qurey)) {
        list.add(qurey
            // .capitalizeInitials()
            );
      }
    } else {
      if (!list.contains(qurey)) {
        list.add(qurey
            //  .capitalizeInitials()
            );
      }
    }

    if (fromHome) {
      searchStore.state.homeSearchHistory = list;
    } else {
      searchStore.state.productsSearchHistory = list;
    }

    await pref.saveListOfString(key, list);
  }

  void getSearchHistory() {
    searchStore.state.productsSearchHistory = pref.getListOfString(prodS);
    searchStore.state.homeSearchHistory = pref.getListOfString(homeS);
  }
}
