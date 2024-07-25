import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/common/functions/no_internet_toast.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/repository/product_firebase.dart';
import 'package:magueyapp/presentation/search/redux/actions.dart';
import 'package:magueyapp/presentation/search/redux/reducer.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/connectivity_service/connectivity_service.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:redux/redux.dart';

class ProductRepo {
  Store<ProductState> store = StoreProvider.of<ProductState>(
    GlobalContext.currentContext!,
    listen: false,
  );
  ProductFirebase productFirebase = ProductFirebase();
  Future<void> getAllProducts() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(ActionGet(
        type: APIsEnum.product,
        status: ResponseStatus.loading,
      ));

      List<ProductModel> products =
          await productFirebase.getProductsFromFirebase(
        categoryId: store.state.categoryId!,
        subCategoryId: store.state.subCategoryId,
      );

      store.dispatch(ActionGet(
        payloadData: products,
        type: APIsEnum.product,
        status: ResponseStatus.success,
      ));
    } else {
      noInternetToast();
    }
  }

  Future<void> getSelectedProduct() async {
    if (await ConnectivityService.connected()) {
      store.dispatch(GetActionSelectedProduct(
        type: APIsEnum.product,
        status: ResponseStatus.loading,
        product: store.state.selectedProduct,
      ));

      if (store.state.selectedProduct == null) {
        store.dispatch(GetActionSelectedProduct(
          type: APIsEnum.product,
          status: ResponseStatus.error,
          error: "Product id not selected",
        ));
      } else {
        ProductModel product = await productFirebase.getSelectedProduct(
          id: store.state.selectedProduct!.id,
        );

        store.dispatch(GetActionSelectedProduct(
          product: product,
          type: APIsEnum.product,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }

  Future<void> getSearchedProducts({
    required String? query,
  }) async {
    if (await ConnectivityService.connected()) {
      if (query == null || query.isEmpty) {
      } else {
        searchStore.dispatch(GetSearchedProductsAction(
          type: APIsEnum.search,
          status: ResponseStatus.loading,
          searchedProducts: null,
        ));

        List<ProductModel> products =
            await productFirebase.getSearchedProducts(query: query);

        searchStore.dispatch(GetSearchedProductsAction(
          searchedProducts: products,
          type: APIsEnum.search,
          status: ResponseStatus.success,
        ));
      }
    } else {
      noInternetToast();
    }
  }
}
