import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/redux/reducer.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/presentation/home/redux/reducer.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/search/redux/reducer.dart';
import 'package:magueyapp/presentation/search/redux/search_state.dart';
import 'package:magueyapp/presentation/shop/redux/reducer.dart';
import 'package:magueyapp/presentation/shop/redux/shop_state.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<HomeState>(
      store: homeStore,
      child: StoreProvider<SearchState>(
        store: searchStore,
        child: StoreProvider<ProductState>(
          store: productStore,
          child: StoreProvider<ReviewState>(
            store: reviewStore,
            child: StoreProvider<ShopState>(
              store: shopStore,
              child: StoreProvider<EventState>(
                store: eventStore,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: GlobalContext.navigatorKey,
                  theme: ThemeData(
                    fontFamily: getIt<String>(instanceName: 'f1'),
                    primarySwatch: MaterialColor(100, MyColors.primarySwatch),
                    primaryColor: MyColors.black0D0D0D,
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: MyColors.black0D0D0D),
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      backgroundColor: Colors.transparent,
                    ),
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: MyColors.whiteFFFFFF,
                    ),
                    checkboxTheme: CheckboxThemeData(
                      splashRadius: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                  themeMode: ThemeMode.light,
                  routes: getIt<AppRoutes>().routes,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
