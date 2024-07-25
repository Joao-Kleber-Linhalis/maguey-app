import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/functions/no_internet_toast.dart';
import 'package:magueyapp/common/widget/custom_circular_loader.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/reducer.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/review/repository/review_firebase.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/connectivity_service/connectivity_service.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:redux/redux.dart';

class ReviewRepo {
  Store<ReviewState> store = StoreProvider.of<ReviewState>(
    GlobalContext.currentContext!,
    listen: false,
  );
  ReviewFirebase reviewFirebase = ReviewFirebase();

  Future<void> sendReview(ReviewState reviewState, ProductModel product) async {
    if (reviewState.rating! < 1.0) {
      MyToast.simple("Atleast 1 star required");
      return;
    }
    if (await ConnectivityService.connected()) {
      CustomCircularLoader.showLoaderDialog();
      ProductReview? review;
      try {
        review = await reviewFirebase.sendReview(reviewState, product.id);

        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        // Error
        CustomCircularLoader.dispose();
        MyToast.simple("Something went wrong, Try Later!");
        return;
      }
      // Success
      CustomCircularLoader.dispose();
      updateReviewInStore(review!);
      GlobalContext.currentContext!.pop();
    } else {
      noInternetToast();
    }
  }

  Future<void> updateReview(
    ReviewState reviewState,
    ProductModel product,
  ) async {
    if (reviewState.rating! < 1.0) {
      MyToast.simple("Atleast 1 star required");
      return;
    }
    if (await ConnectivityService.connected()) {
      CustomCircularLoader.showLoaderDialog();
      ProductReview? review;
      try {
        review = await reviewFirebase.updateReview(reviewState, product.id);

        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        // Error
        CustomCircularLoader.dispose();
        MyToast.simple("Something went wrong, Try Later!");
        return;
      }
      // Success
      CustomCircularLoader.dispose();
      updateReviewInStore(review!, update: true);
      GlobalContext.currentContext!.pop();
      reviewStore.dispatch(SetReviewAction(review: review));
    } else {
      noInternetToast();
    }
  }

  void updateReviewInStore(ProductReview review, {bool update = false}) {
    if (update) {
      productStore.dispatch(UpdateReviewAction(review: review));
    } else {
      productStore.dispatch(AddReviewAction(review: review));
    }
  }
}
