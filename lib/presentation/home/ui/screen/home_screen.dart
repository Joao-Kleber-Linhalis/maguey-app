import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/events/ui/screen/events_screen.dart';
import 'package:magueyapp/presentation/home/ui/screen/item_list_widget.dart';
import 'package:magueyapp/presentation/home/ui/widget/category_list_widget.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_carousel.dart';
import 'package:magueyapp/presentation/map/ui/screen/map_screen.dart';
import 'package:magueyapp/presentation/me_section/ui/screen/me_screen.dart';
import 'package:magueyapp/presentation/widgets/custom_app_bar.dart';
import 'package:magueyapp/service/custom_bottom_navigation_bar_service.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/responsive/responsive.dart';

class MyHomePage extends StatefulWidget {
  static const String route = 'home-screen';

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navbarService = CustomBottomNavigationBarService.instance;

  final List<Widget> _screens = [
    const HomeContent(),
    const MapPage(),
    const EventsScreen(),
    const MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showDivider: false),
      backgroundColor: MyColors.black2B2B2B,
      body: ValueListenableBuilder(
        valueListenable: navbarService.currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return _screens[currentIndex];
        },
      ),
      // bottomNavigationBar: const CustomBottomNavigationBar(), // Adiciona a BottomNavigationBar
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = Responsive.widthOfScreen(context);
    double heightOfScreen = Responsive.heightOfScreen(context);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthOfScreen * 0.05), //20
                  child: Column(
                    children: [
                      Text(
                        'Bienvenidos to a',
                        style: TextStyle(
                          color: const Color(0xFFEDE6D8),
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          height: heightOfScreen * 0.001313,
                          fontFamily: 'CircularAirPro',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: heightOfScreen *0.01,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'brand',
                            style: TextStyle(
                              color: const Color(0xFFEDE6D8),
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              height: heightOfScreen * 0.001813,
                              fontFamily: 'Ogg',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            ' new day.',
                            style: TextStyle(
                              color: const Color(0xFFEDE6D8),
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              height: heightOfScreen * 0.001313,
                              fontFamily: 'CircularAirPro',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: heightOfScreen * 0.035),
                      const HomeCarousel(), // image carousel
                      SizedBox(height: heightOfScreen * 0.035),
                      Text(
                        'Search for the latest in Mezcal and Agave Spirits.',
                        style: TextStyle(
                          color: const Color(0xFFE2D7C1),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: heightOfScreen * 0.0014,
                          fontFamily: 'CircularAirPro',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: heightOfScreen * 0.011667),
                      Text(
                        'Explore bars, restaurants and retailers near you.',
                        style: TextStyle(
                          color: const Color(0xFFE2D7C1),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: heightOfScreen * 0.0014,
                          fontFamily: 'CircularAirPro',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: heightOfScreen * 0.014),
                    ],
                  ),
                ),
                const ItemListWidget(),
                CategoryListWidget(),
                SizedBox(height: heightOfScreen * 0.014),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
