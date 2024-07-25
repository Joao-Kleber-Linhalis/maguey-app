import 'package:magueyapp/presentation/product/model/product_model.dart';

class ProductHeroTag {
  static String productImage(ProductModel product) {
    return "product-${product.id}-image";
  }

  static String productFavourite(ProductModel product) {
    return "product-${product.id}-fav";
  }
}
