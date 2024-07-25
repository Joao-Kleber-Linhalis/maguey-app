import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/functions/search_tap.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/bold_search_icon.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/filter_icon.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/catrgory/view_model/temp_category_filters.dart';
import 'package:magueyapp/presentation/filters/ui/screen/filters_screen.dart';
import 'package:magueyapp/presentation/filters/view_model/filters_list.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/repository/product_repo.dart';
import 'package:magueyapp/presentation/product/ui/widgets/all_products/product_screen.dart';
import 'package:magueyapp/presentation/product/ui/widgets/loaders/all_products_loader_screen.dart';
import 'package:magueyapp/presentation/search/view_model/search_route.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

class AllProductsScreen extends StatefulWidget {
  static const String route = "all_products";
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  ProductRepo productRepo = ProductRepo();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, ProductState>(
      converter: (store) => store.state,
      onInit: (store) => productRepo.getAllProducts(),
      builder: (context, state) => Scaffold(
        appBar: TitledAppBar(
          title: state.categoryId!,
          actionsWidget: state.products != null && state.products!.isNotEmpty
              ? [
                  FilterIcon(onSearchTap: () {
                    FiltersList.selectedFilters = categoryFilters;
                    context.pushNamed(FiltersScreen.route);
                  }),
                  BoldSearchIcon(
                    onSearchTap: () => onSearchTap(SearchRoute.product),
                  ),
                ]
              : null,
        ),
        body: buildUi(state, context),
      ),
    );
  }

  Widget buildUi(ProductState state, BuildContext context) {
    if (state.status == ResponseStatus.loading) {
      return const AllProductsLoaderScreen();
    } else if (state.status == ResponseStatus.success) {
      if (state.products == null || state.products!.isEmpty) {
        return const Center(child: TextView("No products exists"));
      }
      return ProductScreen(state: state);
    }
    return const Center(child: TextView("An Error Occured"));
  }
}
