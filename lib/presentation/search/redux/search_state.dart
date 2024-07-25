import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class SearchState {
  String? searchQuery;
  ResponseStatus? status;
  APIsEnum? type;
  List<ProductModel>? searchedProducts;
  List<String> homeSearchHistory, productsSearchHistory;

  SearchState({
    this.searchQuery,
    this.searchedProducts,
    this.status,
    this.type,
    required this.homeSearchHistory,
    required this.productsSearchHistory,
  });
}
