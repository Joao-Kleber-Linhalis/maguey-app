import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class ProductCategoryOnTap extends Action {
  String categoryId;
  String? subCategoryId;

  ProductCategoryOnTap(this.categoryId, this.subCategoryId) : super();
}

class ProductSelectionAction extends Action {
  ProductModel product;

  ProductSelectionAction(this.product) : super(status: ResponseStatus.loading);
}

class GetActionSelectedProduct {
  ProductModel? product;
  APIsEnum? type;
  ResponseStatus? status;
  String? error;
  GetActionSelectedProduct({
    this.product,
    this.type,
    this.status,
    this.error,
  });
}

class AddReviewAction {
  ProductReview review;

  AddReviewAction({required this.review});
}

class UpdateReviewAction {
  ProductReview review;

  UpdateReviewAction({required this.review});
}
