import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/presentation/product/redux/actions.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/product/ui/widgets/all_products/product_list_tile.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.state,
  });

  final ProductState state;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 100.percentHeight(context),
      child: ListView.builder(
        itemCount: state.products!.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ProductListTile(
          product: state.products![index],
          onTap: (product) {
            // SelectedProduct.product = product;
            StoreProvider.of<ProductState>(context)
                .dispatch(ProductSelectionAction(product));

            if (state.selectedProduct == null) {
              MyToast.simple("Product not selected properly");
            }
          },
          topMargin: index == 0 ? 16 : 0,
          bottomMargin: index == state.products!.length - 1 ? 40 : 16,
        ),
      ),
    );
  }
}
