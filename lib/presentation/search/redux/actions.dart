import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class SearchAction extends Action {
  String searchQuery;

  SearchAction({required this.searchQuery});
}

class HomeSearchAction extends SearchAction {
  String query;
  HomeSearchAction(this.query) : super(searchQuery: query);
}

class SearchProductAction extends SearchAction {
  String query;
  SearchProductAction(this.query) : super(searchQuery: query);
}

class GetSearchedProductsAction {
  final ResponseStatus status;
  final List<ProductModel>? searchedProducts;
  final APIsEnum type;

  GetSearchedProductsAction({
    required this.searchedProducts,
    required this.status,
    required this.type,
  });
}
