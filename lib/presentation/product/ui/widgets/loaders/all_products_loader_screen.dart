import 'package:flutter/material.dart';

import 'product_list_tile_shimmer.dart';

class AllProductsLoaderScreen extends StatelessWidget {
  const AllProductsLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const ProductListTileShimmer();
        });
  }
}
