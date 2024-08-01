import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:magueyapp/presentation/home/model/home_category_model.dart';
import 'package:magueyapp/presentation/home/ui/screen/item_list_widget.dart';
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const Text(
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
                        const Wrap(
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
                        const SizedBox(height: 30),
                        Center(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  MyIcons.backgroudHomeIcon,
                                  height: 381,
                                  width: 381,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                top: 0,
                                right: 0,
                                left: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Mezcal',
                                      style: TextStyle(
                                        color: Color(0xFFE3FF0A),
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                bottom: 10,
                                right: 0,
                                left: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.circle,
                                        size: 10, color: Color(0xFFE6E54A)),
                                    SizedBox(width: 5),
                                    Icon(Icons.circle,
                                        size: 10, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Icon(Icons.circle,
                                        size: 10, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
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
                        const SizedBox(height: 10),
                        const Text(
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
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const ItemListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
