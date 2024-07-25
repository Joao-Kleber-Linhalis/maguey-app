import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_buttons/my_elevated_button.dart';
import 'package:magueyapp/common/widget/my_horizontal_margin.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/review/ui/widgets/add_note_widget.dart';
import 'package:magueyapp/presentation/review/ui/widgets/enter_review_widget.dart';
import 'package:magueyapp/presentation/review/ui/widgets/flavors_tips.dart';
import 'package:magueyapp/presentation/review/ui/widgets/review_product_info.dart';
import 'package:magueyapp/presentation/review/ui/widgets/show_more_tags_button.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class AddReviewScreen extends StatelessWidget {
  static const String route = "add_review";
  const AddReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: StoreConnector<ProductState, ProductState>(
        converter: (store) => store.state,
        builder: (context, productState) => StoreBuilder<ReviewState>(
          onInit: (store) =>
              store.state.selectedReview ??
              store.dispatch(SetReviewAction(review: null)),
          builder: (context, reviewStore) => Scaffold(
            appBar: TitledAppBar(
              title: "",
              titleWidget: TextView(
                "${reviewStore.state.selectedReview != null ? "Edit" : "Add"} Review",
                style: myTextStyle.font_17w700White,
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                25.vSpace(context),
                ReviewProductInfo(product: productState.selectedProduct!),
                21.vSpace(context),
                EnterReviewWidget(state: reviewStore.state),
                MyHorizontalDivider(margin: 16.paddingH(context)),
                19.vSpace(context),
                AddNoteWidget(initialText: reviewStore.state.note),
                19.vSpace(context),
                MyHorizontalDivider(margin: 16.paddingH(context)),
                12.vSpace(context),
                LabeledFlavorsChipColumnView(
                  text: "Flavors Tags",
                  space: 14,
                  trailingWidget: const ShowMoreTagsButton(),
                  rightTrailingMargin: 16,
                  flavors: getFlavorsSuggestion(
                    productState.selectedProduct!,
                    reviewStore.state,
                  ),
                ),
                140.vSpace(context),
              ],
            ),
            floatingActionButton: MyElevatedButton(
              text: "Post",
              buttonRadius: 1000,
              textColor: MyColors.whiteFFFFFF,
              textStyle: myTextStyle.font_16w700,
              buttonBGColor: MyColors.black0D0D0D,
              onPressed: () {
                reviewStore.dispatch(PostReviewButtonTapAction(
                  product: productState.selectedProduct!,
                ));
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ),
      ),
    );
  }

  List<FlavorModel> getFlavorsSuggestion(
    ProductModel product,
    ReviewState state,
  ) {
    List<FlavorModel> flavors = [];
    if (product.topFlavors.isEmpty) {
      flavors = [
        ...product.flavors.sublist(0, product.flavors.length >= 5 ? 6 : null),
        ...state.selectedFlavors ?? [],
      ];
    } else {
      flavors = [...product.topFlavors, ...state.selectedFlavors ?? []];
    }

    // Removing duplicates
    Map<String, FlavorModel> freq = {};

    for (FlavorModel flavor in flavors) {
      String key = flavor.name.toLowerCase();
      if (freq[key] == null) {
        freq[key] = flavor;
      }
    }

    flavors = [...freq.values]..sort(
        (f1, f2) => f2.selected.toString().compareTo(f1.selected.toString()),
      );
    return flavors;
  }
}
