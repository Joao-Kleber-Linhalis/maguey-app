import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/auth/ui/screens/reset_password.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_in.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_up.dart';
import 'package:magueyapp/presentation/folder_structure_boiler_plate/ui/screen/upload_products.dart';
import 'package:magueyapp/presentation/home/ui/screen/home_screen.dart';
import 'package:magueyapp/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:magueyapp/service/custom_bottom_navigation_bar_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final store = CustomBottomNavigationBarService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: store.currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return Navigator(
            key: GlobalKey<NavigatorState>(),
            initialRoute: MyHomePage.route, // Inicia na HomePage
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case MyHomePage.route:
                  builder = (BuildContext _) => const MyHomePage();
                  break;
                case GetStartedScreen.route:
                  builder = (BuildContext _) => const GetStartedScreen();
                  break;
                case SignInScreen.route:
                  builder = (BuildContext _) => const SignInScreen();
                  break;
                case SignUpScreen.route:
                  builder = (BuildContext _) => const SignUpScreen();
                  break;
                case UploadProductsScreen.route:
                  builder = (BuildContext _) => UploadProductsScreen();
                  break;
                case ResetPasswordScreen.route:
                  builder = (BuildContext _) => const ResetPasswordScreen();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
