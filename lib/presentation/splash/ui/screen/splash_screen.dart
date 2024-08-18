// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/main_screen.dart';
import 'package:magueyapp/service/firestore_service/firestore_service.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //SharedPrefsManager pref = new SharedPrefsManager();
  //FirestoreService myFirestoreService = new FirestoreService();

  getUserLastLoginStatus() async {
    //bool isLogin = pref.isUserLogin();
    String route = MainScreen.route;
    // String route = UploadProductsScreen.route;
    await Future.delayed(const Duration(milliseconds: 2500), () {
      context.pushReplacementNamed(route);
    });
  }

  @override
  void initState() {
    getUserLastLoginStatus();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadImagesInPrecache();
  }

  Future<void> loadImagesInPrecache() async {
    await precacheImage(
        const AssetImage(MyImages.startingScreenShape), context);
    await precacheImage(const AssetImage(MyImages.signInScreenShape), context);
    await precacheImage(const AssetImage(MyImages.signUpScreenShape), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.whiteFFFFFF,
      body: SizedBox(
        height: 100.percentHeight(context),
        child: Stack(
          children: [
            Container(
              height: 100.percentHeight(context),
              width: 100.percentWidth(context),
              color: const Color(0xFF2B2B2B),
            ),
            Center(
              child: Image.asset(
                MyIcons.brandIcon,
                height: 131.pxV(context),
                // width: 50.percentWidth(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
