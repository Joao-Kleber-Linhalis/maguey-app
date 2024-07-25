import 'package:magueyapp/presentation/home/model/home_category_model.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/presentation/home/ui/widget/categories_grid.dart';
import 'package:magueyapp/presentation/home/ui/widget/home_appbar.dart';
import 'package:magueyapp/presentation/home/ui/widget/sliver_appbar.dart';
import 'package:magueyapp/presentation/home/view_model/temp_home_category_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/presentation/home/view_model/home_view_model.dart';
import 'package:magueyapp/service/di.dart';

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
    return StoreConnector<HomeState, HomeState>(
      converter: (store) => store.state,
      onInit: (state) {
        model.api();
      },
      builder: (context, data) {
        return Scaffold(
          appBar: homeAppBar(context),
          body: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(),
              HomeCategoriesGrid(categories: homeCategories),
            ],
          ),
        );
      },
    );
  }
}
