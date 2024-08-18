import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/main_screen.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/app_routes/app_routes.dart';

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
        primaryColor: const Color(0xFF2B2B2B),
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
      // home: GetStartedScreen(),
      routes: getIt<AppRoutes>().routes,
    );
  }
}
