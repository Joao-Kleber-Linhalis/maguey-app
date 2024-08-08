import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:magueyapp/presentation/home/model/home_category_model.dart';
import 'package:magueyapp/presentation/home/ui/screen/item_list_widget.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_carousel.dart';
import 'package:magueyapp/presentation/home/view_model/temp_home_category_json.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/home/view_model/home_view_model.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_icons.dart';

class MyHomePage extends StatefulWidget {
  static const String route = 'home-screen';

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loader = false;

  final model = getIt<HomeViewModel>();

  List<HomeCategoryModel> homeCategories = [];

  @override
  void initState() {
    homeCategories = homeCategoryJson
        .map((category) => HomeCategoryModel.fromJson(category))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Image.asset(
              MyIcons.brandIcon,
              height: 50,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'Bienvenidos to a',
                          style: TextStyle(
                            color: Color(0xFFEDE6D8),
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            height: 45 / 40,
                            fontFamily: 'CircularAirPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'brand',
                              style: TextStyle(
                                color: Color(0xFFEDE6D8),
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                height: 45 / 40,
                                fontFamily: 'Ogg',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              ' new day.',
                              style: TextStyle(
                                color: Color(0xFFEDE6D8),
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                                height: 45 / 40,
                                fontFamily: 'CircularAirPro',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        HomeCarousel(), //Carrosel
                        SizedBox(height: 30),
                        Text(
                          'Search for the latest in Mezcal and Agave Spirits.',
                          style: TextStyle(
                            color: Color(0xFFE2D7C1),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            height: 24 / 20,
                            fontFamily: 'CircularAirPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Explore bars, restaurants and retailers near you.',
                          style: TextStyle(
                            color: Color(0xFFE2D7C1),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            height: 24 / 20,
                            fontFamily: 'CircularAirPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  ItemListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
