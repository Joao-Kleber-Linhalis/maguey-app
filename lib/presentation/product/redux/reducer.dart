import 'package:magueyapp/base_redux/base_action.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/ui/screen/product_details_screen.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:redux/redux.dart';

final productStore = Store<ProductState>(
  productReducer,
  initialState: ProductState(categoryId: ""), // Initial state
);

ProductState productReducer(ProductState newState, dynamic action) {
  if (action is ActionGet) {
    newState.status = action.status;
    newState.products = action.payloadData as List<ProductModel>?;
    newState.apiType = action.type;
  } else if (action is ProductCategoryOnTap) {
    if (action.subCategoryId != null) {
      newState.subCategoryId = action.subCategoryId;
    } else {
      newState.categoryId = action.categoryId;
      newState.subCategoryId = null;
    }
  } else if (action is GetActionSelectedProduct) {
    newState.selectedProduct = action.product;
    newState.status = action.status;
    newState.apiType = action.type;
    newState.products = productStore.state.products;
  } else if (action is ProductSelectionAction) {
    newState = _onProductSelectionAction(action, newState);
  } else if (action is AddReviewAction) {
    newState = _addReviewAction(action.review, newState);
  } else if (action is UpdateReviewAction) {
    newState = _updateReviewAction(action.review, newState);
  }

  return newState;
}

ProductState _onProductSelectionAction(
  ProductSelectionAction action,
  ProductState state,
) {
  state.selectedProduct = action.product;
  state.status = action.status;
  GlobalContext.currentContext!.pushNamed(ProductDetailsScreen.route);

  return state;
}

ProductState _addReviewAction(ProductReview review, ProductState state) {
  /// Append code heres
  state.selectedProduct!.reviews.add(review);
  state.selectedProduct!.myReview = review;
  return state;
}

ProductState _updateReviewAction(ProductReview newReview, ProductState state) {
  /// Append code heres
  int index = 0;
  for (int i = 0; i < state.selectedProduct!.reviews.length; i++) {
    ProductReview review = state.selectedProduct!.reviews[i];
    if (review.userId == newReview.userId) {
      index = i;
      break;
    }
  }
  state.selectedProduct!.reviews[index] = newReview;
  state.selectedProduct!.myReview = newReview;
  // state.selectedProduct!.reviews.add(review);
  return state;
}
