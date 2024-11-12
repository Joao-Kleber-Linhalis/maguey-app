import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/data/user_controller.dart';
import 'package:magueyapp/provider/dashboard_provider.dart';
import 'package:magueyapp/provider/google_sign_in_provider.dart';
import 'package:magueyapp/provider/log_in_sign_up_provider.dart';
import 'package:magueyapp/provider/user_provider.dart';
import 'package:magueyapp/ui/features/home/home_screen.dart';
import 'package:magueyapp/ui/features/log_in/log_in.dart';
import 'package:magueyapp/ui/widgets/internet_checker.dart';
import 'package:provider/provider.dart';

import 'design_system/colors.dart';
import 'theme/my_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Failed to initialize Firebase: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LogInSignUpProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> GlobalContext = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContext,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: DSColors.greyScaleWhite,
        colorScheme: const ColorScheme.light(
          primary: MyColors.black2B2B2B,
        ),
        useMaterial3: true,
        cardTheme: const CardTheme(),
      ),
      home: Material(
        child: FutureBuilder<bool>(
          future: checkInternetConnection(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == false) {
              return const NoInternetReload(reloadScreen: MyApp());
            }
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.active) {
                  return authSnapshot.hasData
                      ? const MyHomePage()
                      : const LogInScreen();
                }
                return const CircularProgressIndicator();
              },
            );
          },
        ),
      ),
    );
  }
}

Future<bool> checkInternetConnection() async {
  bool hasInternet = false;
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    hasInternet = false;
  } else {
    hasInternet = true;
  }
  return hasInternet;
}

void setCurrentUser() async {
  UserProvider().setCurrentUser(await UserController()
      .searchUser(FirebaseAuth.instance.currentUser!.uid));
}
