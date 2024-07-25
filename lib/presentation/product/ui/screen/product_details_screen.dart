import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_buttons/my_elevated_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/common/widget/appbar_icon_button.dart';
import 'package:magueyapp/presentation/product/model/product_model.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/repository/product_repo.dart';
import 'package:magueyapp/presentation/product/ui/widgets/loaders/product_details_screen_shimmer.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/flavor_profile/flavour_profile_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/description/product_description_container.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_details/product_details_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_info/product_info_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/reviews/product_reviews_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/product_top_flavour_widget.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/review/ui/screen/add_review_screen.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String route = "product_details";
  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool isAllReviewsTapped = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, ProductState>(
      converter: (store) => store.state,
      onInit: (store) async => await ProductRepo().getSelectedProduct(),
      builder: (context, state) => Scaffold(
        backgroundColor: MyColors.greyF5F5F5,
        appBar: TitledAppBar(
          title: "",
          actionsWidget: [
            // ProductFavouriteButton(product: state.selectedProduct!),
            if (state.status == ResponseStatus.success)
              MyAppbarIconButton(
                onTap: () async => await shareProduct(state.selectedProduct!),
                icon: MyIcons.shareIcon,
                width: 19,
              ),
          ],
        ),
        body: buildUi(state, context),
        floatingActionButton: state.status == ResponseStatus.success
            ?
            //  Hero(
            //      tag: ReviewHeroTag.heading(state.selectedProduct!),
            //     child:
            state.selectedProduct!.myReview == null
                ? buildButton(
                    "Add Review",
                    () => context.pushNamed(AddReviewScreen.route),
                  )
                : StoreBuilder<ReviewState>(
                    builder: (context, store) => buildButton(
                      "Edit Review",
                      () {
                        store.dispatch(
                          SetReviewAction(
                            review: state.selectedProduct!.myReview,
                          ),
                        );
                        context.pushNamed(AddReviewScreen.route);
                      },
                    ),
                  )
            //  )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildButton(String text, Function() onTap) {
    return MyElevatedButton(
      text: text,
      buttonRadius: 1000,
      textColor: MyColors.whiteFFFFFF,
      textStyle: myTextStyle.font_16w700,
      buttonBGColor: MyColors.black0D0D0D,
      onPressed: onTap,
    );
  }

  buildUi(ProductState state, BuildContext context) {
    if (state.status == ResponseStatus.loading) {
      return const ProductDetailsScreenShimmer(); //const CustomLoaderWidget();
    } else if (state.status == ResponseStatus.success) {
      if (state.products == null || state.products!.isEmpty) {
        return const Center(child: TextView("No product exists"));
      }
      return productDetailScreen(state, context);
    }
    return const Center(child: TextView("An Error Occured"));
  }

  Widget productDetailScreen(ProductState state, BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ProductDetailsContainer(product: state.selectedProduct!),
        TopFlavoursContainer(product: state.selectedProduct!),
        DescriptionContainer(description: state.selectedProduct!.description),
        ProductInfoContainer(product: state.selectedProduct!),
        FlavourProfileContainer(product: state.selectedProduct!),
        ProductReviewsContainer(
          product: state.selectedProduct!,
          btmMargin: 100,
          onTapOfShowAll: () {
            setState(() => isAllReviewsTapped = !isAllReviewsTapped);
          },
          isAllReviewsTapped: isAllReviewsTapped,
        ),
      ],
    );
  }

  Future<void> shareProduct(ProductModel product) async {
    await Share.shareUri(Uri.parse(product.imageUrl));
  }
}
