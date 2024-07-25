import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/redux/reducer.dart';
import 'package:magueyapp/presentation/product/repository/product_repo.dart';
import 'package:magueyapp/presentation/product/ui/widgets/all_products/product_list_tile.dart';
import 'package:magueyapp/presentation/product/ui/widgets/loaders/all_products_loader_screen.dart';
import 'package:magueyapp/presentation/search/redux/search_state.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class SearchProductsScreen extends StatefulWidget {
  static const String route = "search_products";
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  ProductRepo productRepo = ProductRepo();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, SearchState>(
      converter: (store) => store.state,
      onInit: (store) =>
          productRepo.getSearchedProducts(query: store.state.searchQuery),
      builder: (context, state) => Scaffold(
        appBar: const TitledAppBar(title: "Product Search Results"),
        body: buildUi(state, context),
      ),
    );
  }

  buildUi(SearchState state, BuildContext context) {
    if (state.status == ResponseStatus.loading) {
      return const AllProductsLoaderScreen();
    } else if (state.status == ResponseStatus.success) {
      if (state.searchedProducts == null || state.searchedProducts!.isEmpty) {
        return const Center(child: TextView("No search results"));
      }
      return productsScreen(state, context);
    }
    return const Center(child: TextView("An Error Occured"));
  }

  productsScreen(SearchState state, BuildContext context) {
    return SizedBox(
      height: 100.percentHeight(context),
      child: ListView.builder(
        itemCount: state.searchedProducts!.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ProductListTile(
          product: state.searchedProducts![index],
          onTap: (product) {
            // SelectedProduct.product = product;
            StoreProvider.of<ProductState>(context)
                .dispatch(ProductSelectionAction(product));
            if (productStore.state.selectedProduct != null) {
              //    context.pushNamed(ProductDetailsScreen.route);
            } else {
              MyToast.simple("Product not selected properly");
            }
          },
          topMargin: index == 0 ? 16 : 0,
          bottomMargin: index == state.searchedProducts!.length - 1 ? 40 : 16,
        ),
      ),
    );
  }
}
