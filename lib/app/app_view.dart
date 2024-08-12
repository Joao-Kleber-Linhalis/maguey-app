import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/app_routes/app_routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalContext.navigatorKey,
      theme: ThemeData(
        fontFamily: getIt<String>(instanceName: 'f1'),
        primarySwatch: MaterialColor(100, MyColors.primarySwatch),
        primaryColor: MyColors.black0D0D0D,
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.black0D0D0D),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: MyColors.whiteFFFFFF,
        ),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
      themeMode: ThemeMode.light,
      routes: getIt<AppRoutes>().routes,
    );
  }
}
