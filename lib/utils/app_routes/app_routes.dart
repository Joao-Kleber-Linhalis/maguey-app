import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/auth/ui/screens/reset_password.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_in.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_up.dart';
import 'package:magueyapp/presentation/folder_structure_boiler_plate/ui/screen/upload_products.dart';
import 'package:magueyapp/presentation/home/ui/screen/home_screen.dart';
import 'package:magueyapp/presentation/main_screen.dart';
import 'package:magueyapp/presentation/splash/ui/screen/splash_screen.dart';

class AppRoutes {
  final Map<String, Widget Function(BuildContext)> routes = {
    MainScreen.route : (_) => const MainScreen(),
    SplashScreen.route: (_) => const SplashScreen(),
    UploadProductsScreen.route: (_) => UploadProductsScreen(),
    GetStartedScreen.route: (_) => const GetStartedScreen(),
    SignInScreen.route: (_) => const SignInScreen(),
    SignUpScreen.route: (_) => const SignUpScreen(),
    MyHomePage.route: (_) => const MyHomePage(),
    ResetPasswordScreen.route: (_) => const ResetPasswordScreen(),
  };

  // Animated Push
  Widget returnScreen(String route, {Object? arg}) {
    switch (route) {
      // For Get Start Screen
      case GetStartedScreen.route:
        return const GetStartedScreen();

      // For Sign in screen
      case SignInScreen.route:
        return const SignInScreen();

      // For Sign Up screen
      case SignUpScreen.route:
        return const SignUpScreen();

      // For Reset Password screen
      case ResetPasswordScreen.route:
        return const ResetPasswordScreen();

      // For Homepage screen
      case MyHomePage.route:
        return const MyHomePage();

      default:
        return Scaffold(
          body: Center(child: Text("No Route with name $route")),
        );
    }
  }
}
