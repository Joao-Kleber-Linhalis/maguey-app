import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../custom_app_bar.dart';
import '../../../provider/dashboard_provider.dart';
import '../../../service/custom_bottom_navigation_bar.dart';
import '../../../theme/my_colors.dart';
import '../events/events_list.dart';
import '../map/map_screen.dart';
import '../me_section/ui/screen/me_screen.dart';
import 'category_list_widget.dart';
import 'home_carousel.dart';

class MyHomePage extends StatefulWidget {
  static const String route = 'home-screen';

  final bool comoFromLogin;

  const MyHomePage({super.key, this.comoFromLogin = false});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navbarService = CustomBottomNavigationBarService.instance;

  late Future loadAppData;
  @override
  void initState() {
    loadAppData = Provider.of<DashboardProvider>(context, listen: false)
        .loadDataGetUserInformation();
    if (widget.comoFromLogin) {
      navbarService.currentIndexNotifier.value = 0;
    }
    super.initState();
  }

  final List<Widget> _screens = [
    const HomeContent(),
    const LoadMap(),
    const EventsList(),
    const MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAppData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: const CustomAppBar(showDivider: true),
          backgroundColor: MyColors.black2B2B2B,
          body: ValueListenableBuilder(
            valueListenable: navbarService.currentIndexNotifier,
            builder: (context, currentIndex, child) {
              return _screens[currentIndex];
            },
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
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
                        height: heightOfScreen * 0.01,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'brand  ',
                            style: TextStyle(
                              color: const Color(0xFFEDE6D8),
                              fontSize: 34,
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
                        'Search for the latest in Mezcal and Agave Spirits. Explore bars, restaurants and retailers near you.',
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

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final store = CustomBottomNavigationBarService.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          color: Color(0xFF908C00),
          thickness: 0.5,
          height: 0.5,
        ),
        ValueListenableBuilder<int>(
          valueListenable: store.currentIndexNotifier,
          builder: (context, currentIndex, child) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: 'MAP',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: 'EVENTS',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: 'ME',
                ),
              ],
              onTap: (index) {
                store.setCurrentIndex(index);
              },
              backgroundColor: const Color(0xFF2B2B2B),
              selectedItemColor: const Color(0xFFE3FF0A),
              unselectedItemColor: const Color(0xFF908C00),
              selectedLabelStyle: const TextStyle(
                fontFamily: 'CircularXXMono',
                fontSize: 12,
                letterSpacing: 0.2,
                color: Color(0xFFE6E54A),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFE6E54A),
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'CircularXXMono',
                fontSize: 12,
                letterSpacing: 0.2,
                color: Colors.grey,
              ),
              type: BottomNavigationBarType.fixed,
            );
          },
        ),
      ],
    );
  }
}
