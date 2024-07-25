import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class ProductState {
  ResponseStatus? status;
  List<ProductModel>? products, searchedProducts;
  String? categoryId;
  String? subCategoryId;
  ProductModel? selectedProduct;
  APIsEnum? apiType;

  ProductState({
    this.status,
    this.products,
    this.categoryId,
    this.subCategoryId,
    this.selectedProduct,
    this.apiType,
    this.searchedProducts,
  });

  ProductState.fromState(ProductState state) {
    status = state.status;
    products = state.products;
    categoryId = state.categoryId;
    subCategoryId = state.subCategoryId;
    selectedProduct = state.selectedProduct;
    apiType = state.apiType;
    searchedProducts = state.searchedProducts;
  }
}
