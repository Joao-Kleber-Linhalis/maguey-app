import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/review/repository/review_repo.dart';

import 'package:redux/redux.dart';

final reviewStore = Store<ReviewState>(
  reviewReducer,
  initialState: ReviewState(
    selectedFlavors: {},
    rating: 0.0,
    note: "",
  ), // Initial state
);

ReviewState reviewReducer(ReviewState newState, dynamic action) {
  if (action is AddFlavorToReviewAction) {
    _addFlavorToReview(action);
  } else if (action is RemoveFlavorFromReviewAction) {
    _removeFlavorFromReview(action);
  } else if (action is AddReviewNoteAction) {
    newState.note = action.text;
  } else if (action is PostReviewButtonTapAction) {
    _createUsersReview(action, newState);
  } else if (action is SetReviewAction) {
    newState = _setReview(action);
  } 
  
  // else if (action is SetReviewAction) {
  //   newState.note = action.review!.note;
  //   newState.rating = action.review!.rating;
  //   newState.selectedFlavors = Set.from(action.review!.flavors);
  // }

  return newState;
}

void _createUsersReview(PostReviewButtonTapAction action, ReviewState state) {
  ReviewRepo reviewRepo = ReviewRepo();
  if (state.selectedReview == null) {
    reviewRepo.sendReview(state, action.product);
  } else {
    reviewRepo.updateReview(state, action.product);
  }
}

ReviewState _setReview(SetReviewAction action) {
  if (action.review == null) {
    _unSelectAllFlavors(productStore.state.selectedProduct!.flavors);
    _unSelectAllFlavors(productStore.state.selectedProduct!.topFlavors);
    return ReviewState(selectedFlavors: {}, note: "", rating: 0.0);
  }
  Set<FlavorModel> flavors = action.review!.flavors
      .map((e) => FlavorModel.fromJson(e)..toggleSelection(value: true))
      .toSet();
  _setFlavorSelectionInProductModel(flavors, true);
  return ReviewState(
    selectedReview: action.review,
    selectedFlavors: flavors,
    note: action.review!.note,
    rating: action.review!.rating,
  );
}

void _addFlavorToReview(AddFlavorToReviewAction action) {
  Set<FlavorModel> flavors = reviewStore.state.selectedFlavors!;
  flavors.add(action.flavor);
  action.flavor.toggleSelection(value: true);
  _updateFlavorSelectionInProductModel(action.flavor, true);
}

void _removeFlavorFromReview(RemoveFlavorFromReviewAction action) {
  reviewStore.state.selectedFlavors!.remove(action.flavor);
  _updateFlavorSelectionInProductModel(action.flavor, false);
}

void _updateFlavorSelectionInProductModel(FlavorModel flavor, bool val) {
  List<FlavorModel> topFlavors = productStore.state.selectedProduct!.topFlavors;
  _changeTheProductFlavor(flavor, topFlavors, val);

  List<FlavorModel> allFlavors = productStore.state.selectedProduct!.flavors;
  _changeTheProductFlavor(flavor, allFlavors, val);
}

void _changeTheProductFlavor(
  FlavorModel selectedFlavor,
  List<FlavorModel> flavors,
  bool val,
) {
  for (FlavorModel flavor in flavors) {
    if (flavor.name.toLowerCase() == selectedFlavor.name.toLowerCase()) {
      flavor.toggleSelection(value: val);
      break;
    }
  }
}

void _unSelectAllFlavors(List<FlavorModel> flavors) {
  for (FlavorModel flavor in flavors) {
    flavor.toggleSelection(value: false);
  }
}

void _setFlavorSelectionInProductModel(Set<FlavorModel> flavors, bool val) {
  List<FlavorModel> topFlavors = productStore.state.selectedProduct!.topFlavors;
  _setTheProductFlavorsInList(flavors.toList(), topFlavors, val);

  List<FlavorModel> allFlavors = productStore.state.selectedProduct!.flavors;
  _setTheProductFlavorsInList(flavors.toList(), allFlavors, val);
}

void _setTheProductFlavorsInList(
  List<FlavorModel> flavors,
  List<FlavorModel> allFlavors,
  bool val,
) {
  Map<String, FlavorModel> map = {};

  for (FlavorModel flavor in flavors) {
    map.addEntries({flavor.name: flavor}.entries);
  }

  for (FlavorModel flavor in allFlavors) {
    if (map[flavor.name] != null) {
      flavor.toggleSelection(value: val);
    }
  }
}
