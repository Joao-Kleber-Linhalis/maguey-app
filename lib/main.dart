import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/data/user_controller.dart';
import 'package:magueyapp/provider/dashboard_provider.dart';
import 'package:magueyapp/provider/external_sign_in_provider.dart';
import 'package:magueyapp/provider/log_in_sign_up_provider.dart';
import 'package:magueyapp/provider/user_provider.dart';
import 'package:magueyapp/ui/features/home/home_screen.dart';
import 'package:magueyapp/ui/features/log_in/log_in.dart';
import 'package:magueyapp/ui/widgets/internet_checker.dart';
import 'package:provider/provider.dart';

import 'design_system/colors.dart';
import 'theme/my_colors.dart';

final globalNavigator = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status == TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
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
        ChangeNotifierProvider(create: (context) => ExternalSignInProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> createUser(User user) async {
    final userExists = await UserController().userExist(user.uid);
    if (!userExists) {
      String profilePicture =
          'https://firebasestorage.googleapis.com/v0/b/spend-ninja-dev.appspot.com/o/no_profile_image.jpg?alt=media&token=228ab9ab-831c-4c3b-8935-f1d32db2366a';

      await UserProvider().createNewUser(
        userId: user.uid,
        signUpEmail: user.email ?? '',
        profilePicture: profilePicture,
      );
    }
    return const MyHomePage(
      key: ValueKey('HomeScreen'),
      comoFromLogin: true,
    );
  }

  Widget _checkAndCreateUser(User user) {
    try {
      createUser(user);
    } catch (e) {
      debugPrint('Erro ao criar usuário no banco: $e');
      return const LogInScreen(key: ValueKey('LogInScreen'));
    }

    return const LogInScreen(key: ValueKey('LogInScreen'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: globalNavigator,
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
                  return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1,
                                0), // Direção de entrada (direita para esquerda)
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: const MyHomePage(
                        key: ValueKey('HomeScreen'),
                        comoFromLogin: true,
                      ));
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
