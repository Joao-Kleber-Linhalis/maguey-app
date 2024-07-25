import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/presentation/catrgory/model/category_model.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/category_list_tile.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/catrgory/view_model/sub_category_json.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/ui/screen/all_products_screen.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

class CategoryScreen extends StatefulWidget {
  static const String route = "category";
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    getAllCategories();
    super.initState();
  }

  getAllCategories() {
    categories = categoriesJson
        .map((category) => CategoryModel.fromJson(category))
        .toList()
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitledAppBar(
        title: "Categories",
        // actionsWidget: [
        //   FilterIcon(onSearchTap: () {
        //     FiltersList.selectedFilters = categoryFilters;
        //     context.pushNamed(FiltersScreen.route);
        //   }),
        //   BoldSearchIcon(
        //     onSearchTap: () => onSearchTap(SearchRoute.product),
        //   ),
        // ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryListTile(
              category: categories[index],
              topMargin: index == 0 ? 30.pxV(context) : 0,
              bottomMargin: index == categories.length - 1
                  ? 10.percentHeight(context)
                  : 10,
              onTap: (category) {
                StoreProvider.of<ProductState>(context, listen: false)
                    .dispatch(ProductCategoryOnTap("", category.title));
                context.pushNamed(AllProductsScreen.route);
              });
        },
      ),
    );
  }
}
