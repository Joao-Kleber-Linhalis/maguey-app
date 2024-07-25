// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/home/ui/screen/base_screen.dart';
import 'package:magueyapp/presentation/search/view_model/search_storage_manager.dart';
import 'package:magueyapp/service/di.dart';
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
  SharedPrefsManager pref = getIt<SharedPrefsManager>();
  FirestoreService myFirestoreService = getIt<FirestoreService>();

  getUserLastLoginStatus() async {
    bool isLogin = pref.isUserLogin();
    String route = isLogin ? BaseScreen.route : GetStartedScreen.route;
    // String route = UploadProductsScreen.route;
    await Future.delayed(const Duration(milliseconds: 2500), () {
      context.pushReplacementNamed(route);
    });
  }

  @override
  void initState() {
    getUserLastLoginStatus();
    SearchStorageManager().getSearchHistory();
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
            Image.asset(
              MyImages.splashBg,
              fit: BoxFit.fitHeight,
              height: 100.percentHeight(context),
              // height: 131.pxV(context),
              // width: 50.percentWidth(context),
            ),
            Container(
              height: 100.percentHeight(context),
              width: 100.percentWidth(context),
              color: MyColors.black000000.withOpacity(0.65),
            ),
            Center(
              child: Image.asset(
                MyImages.logo,
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
