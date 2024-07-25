import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/review/model/product_reviews.dart';

class AddFlavorToReviewAction {
  FlavorModel flavor;

  AddFlavorToReviewAction({required this.flavor});
}

class RemoveFlavorFromReviewAction {
  FlavorModel flavor;

  RemoveFlavorFromReviewAction({required this.flavor});
}

class AddReviewNoteAction {
  String text;

  AddReviewNoteAction({required this.text});
}

class PostReviewButtonTapAction {
  ProductModel product;

  PostReviewButtonTapAction({required this.product});
}

class SetReviewAction {
  ProductReview? review;
  SetReviewAction({required this.review});
}
