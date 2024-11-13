import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/dashboard_provider.dart';
import '../../../../../theme/my_colors.dart';
import '../../../../../theme/text_styling.dart';
import '../../../../../utils/app_route.dart';
import '../../../product/suggest_product.dart';
import '../sub_screens/me_delete_account.dart';
import '../sub_screens/me_logout.dart';
import '../sub_screens/me_support.dart';
import '../sub_screens/me_terms.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  late DashboardProvider dashboardProvider;
  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subScreens = [
/*      {
        "option": "Favorites products",
        "onTap": () => MeFavoritesProducts.navigateTo(context),
      },
      {
        "option": "Favorites events",
        "onTap": () => MeEventsEvents.navigateTo(context),
      },*/
      {
        "option": "Suggest a Product",
        "onTap": () => AppRoutes.push(context, const SuggestAProduct()),
      },
      {
        "option": "Terms & Conditions",
        "onTap": () => MeTerms.navigateTo(context),
      },
      {
        "option": "Support",
        "onTap": () => MeSupport.navigateTo(context),
      },
      {
        "option": "Logout",
        "onTap": () => MeLogout.showLogoutDialog(context),
      },
      {
        "option": "Delete Account",
        "onTap": () => MeDeleteAccount.showDeleteAccountDialog(context),
      },
    ];
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: heightOfScreen * 0.046667),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    'Me',
                                    style: TextStyle(
                                      color: const Color(0xFFE6E54A),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                      height: heightOfScreen * 0.001313,
                                      fontFamily: 'CircularAirPro',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  AutoSizeText(
                                    dashboardProvider.currentUser.email,
                                    style: TextStyleCustom()
                                        .font_12w400
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: MyColors.yellowE2D7C1,
                                            fontSize: 16.5,
                                            fontFamily: "CircularXXMono"),
                                  ),
                                  AutoSizeText(
                                    'Created at ${DateFormat('MMMM yyyy').format(dashboardProvider.currentUser.createdAt)}', //User create data
                                    style: TextStyleCustom()
                                        .font_12w400
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: MyColors.yellowE2D7C1
                                                .withOpacity(0.5),
                                            fontSize: 16.5,
                                            letterSpacing: 1,
                                            fontFamily: "CircularXXMono"),
                                  ),
                                  const SizedBox(height: 10),
                                  AutoSizeText(
                                    'This is where you can keep track of all your activity.', //Default text
                                    style: TextStyleCustom()
                                        .font_12w400
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: MyColors.yellowE2D7C1,
                                            fontSize: 10,
                                            fontFamily: "CircularAirPro"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: heightOfScreen * 0.03),
                    ],
                  ),
                ),
                _buildDivider(),
                ...List.generate(
                  subScreens.length,
                  (index) {
                    return Column(
                      children: [
                        _buildSubScreen(
                            title: subScreens[index]["option"],
                            onTap: subScreens[index]["onTap"],
                            heightOfScreen: heightOfScreen,
                            widthOfScreen: widthOfScreen,
                            context: context),
                        if (index != subScreens.length - 1)
                          _buildDivider(), //dont build divider in the last subscreen , Maybe remove
                      ],
                    );
                  }, //category-> brand-> product
                ),
                const SizedBox(height: 16)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSubScreen({
  required String title,
  required VoidCallback onTap, //Maybe
  required double heightOfScreen,
  required double widthOfScreen,
  required BuildContext context,
}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: widthOfScreen,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: heightOfScreen * 0.046667,
          vertical: heightOfScreen * 0.0005,
        ),
        child: AutoSizeText(
          title,
          style: TextStyleCustom().font_12w400.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.yellowE2D7C1,
              fontSize: 14,
              fontFamily: "CircularAirPro"),
          textAlign: TextAlign.start,
        ),
      ),
    ),
  );
}

Widget _buildDivider() {
  //to make a dotted line, can try dotted_line 3.2.2.
  return const Divider(
    color: Color(0xFF908C00),
    thickness: 0.5,
    height: 30,
  );
}
