import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class ReviewState {
  ResponseStatus? status;
  Set<FlavorModel>? selectedFlavors;
  APIsEnum? apiType;
  String? note = "";
  double? rating = 0.0;
  String? errorMessage;
  ProductReview? selectedReview;

  ReviewState({
    this.status,
    this.selectedFlavors,
    this.apiType,
    this.rating,
    this.note,
    this.errorMessage,
    this.selectedReview,
  });

  ReviewState.fromState(ReviewState state) {
    status = state.status;
    selectedFlavors = state.selectedFlavors;
    apiType = state.apiType;
    rating = state.rating;
    note = state.note;
    errorMessage = state.errorMessage;
    selectedReview = state.selectedReview;
  }
}
