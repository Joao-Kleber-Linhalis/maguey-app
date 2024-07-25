// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/custom_circular_loader.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/auth/repository/auth_repository.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:magueyapp/presentation/profile/ui/widgets/delete_profile_widget.dart';
import 'package:magueyapp/presentation/profile/ui/widgets/logout_widget.dart';
import 'package:magueyapp/presentation/profile/ui/widgets/profile_acton_tile.dart';
import 'package:magueyapp/presentation/profile/ui/widgets/profile_widget.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "profile_screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitledAppBar(title: "Profile"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ProfileWidget(),
              59.vSpace(context),
              ProfileActionTile(
                text: "Privacy Policy",
                imagePath: MyIcons.privacyPolicy,
                color: MyColors.black0D0D0D,
                onTap: () => context.pushNamed(PrivacyPolicy.route),
              ),
              32.vSpace(context),
              ProfileActionTile(
                text: "Delete Account",
                imagePath: MyIcons.deleteAccount,
                onTap: () => deleteAccount(context, (val) async {
                  if (val) {
                    await deleteUserAccount();
                  }
                }),
              ),
              32.vSpace(context),
              ProfileActionTile(
                text: "Logout",
                imagePath: MyIcons.logout,
                onTap: () => logout(
                  context,
                  onLogoutTap: () => onLogoutTap(context),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  'Powered by',
                  style: myTextStyle.font_15w700Black.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _launchUrl,
                  child: Container(
                    width: 110,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 27, 28, 30),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(130, 237, 125, 58),
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value)
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Maze Digital',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://www.mazedigitals.com/');

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> onLogoutTap(BuildContext context) async {
    CustomCircularLoader.showLoaderDialog();
    AuthRepository repo = getIt<AuthRepository>();

    bool logout = await repo.logoutUser();
    await Future.delayed(const Duration(milliseconds: 400));

    if (logout) context.pushNamedAndRemoveUntil(GetStartedScreen.route);
  }

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      await deleteUserDocument();
    } on FirebaseAuthException {
      MyToast.simple("Log in again before retrying this request.",
          timeInSec: 10);
    } catch (e) {
      MyToast.simple(e.toString(), timeInSec: 10);
    }
  }

  Future<void> deleteUserDocument() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        MyToast.simple("User is not Authenticated", timeInSec: 3);
        return;
      }

      final userId = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).delete();

      MyToast.simple("User Deleted Successfully", timeInSec: 3);
    } catch (e) {
      MyToast.simple("'Error while deleting the user document: $e'",
          timeInSec: 3);
    }
  }
}
