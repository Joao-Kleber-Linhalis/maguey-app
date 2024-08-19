import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_events.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_favorites.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_logout.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_reviews.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_settings.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_submit_product.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_support.dart';
import 'package:magueyapp/presentation/me_section/ui/sub_screens/me_terms.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/responsive/responsive.dart';

final textStyles = TextStyleCustom();

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subScreens = [
      //Map with option name and function to navi.
      //Its works
      {
        "option": "Reviews",
        "onTap": () => MeReviews.navigateTo(context),
      },
      {
        "option": "Favorites",
        "onTap": () => MeFavorites.navigateTo(context),
      },
      {
        "option": "Events",
        "onTap": () => MeEvents.navigateTo(context),
      },
      {
        "option": "Submit a Product",
        "onTap": () => MeSubmitProduct.navigateTo(context),
      },
      {
        "option": "Account Settings",
        "onTap": () => MeSettings.navigateTo(context),
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
    ];
    double widthOfScreen = Responsive.widthOfScreen(context);
    double heightOfScreen = Responsive.heightOfScreen(context);
    return SafeArea(
      child: Column(
        children: [
          _buildDivider(), //Maybe remove
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
                                    'Abe Vizcarra', //User name
                                    style: textStyles.font_12w400.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.brown97805F,
                                        fontSize: 27,
                                        fontFamily: "InstrumentSerif"),
                                  ),
                                  AutoSizeText(
                                    '@abevizzy', //User @
                                    style: textStyles.font_12w400.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: MyColors.yellowE2D7C1,
                                        fontSize: 16.5,
                                        fontFamily: "CircularXXMono"),
                                  ),
                                  AutoSizeText(
                                    'Joined January 2024', //User create data
                                    style: textStyles.font_12w400.copyWith(
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
                                    style: textStyles.font_12w400.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: MyColors.yellowE2D7C1,
                                        fontSize: 10,
                                        fontFamily: "CircularAirPro"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            bottom: 40,
                            child: CircleAvatar(
                              radius: widthOfScreen * 0.15,
                              backgroundColor: Colors.grey[200],
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png', //Example Image - Change for the user ImageProfile URL
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/profile/profile_default_2.png', //Default image in case the profile image loads error
                                  ),
                                  fit: BoxFit.cover,
                                  width: widthOfScreen * 0.30,
                                  height: widthOfScreen * 0.30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: heightOfScreen * 0.03,
                      ),
                    ],
                  ),
                ),
                _buildDivider(),
                ...List.generate(
                  //List of subscreen
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
                  },
                )
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
          style: textStyles.font_12w400.copyWith(
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
