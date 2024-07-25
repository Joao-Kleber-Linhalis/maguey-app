import 'package:magueyapp/presentation/product/model/product_model.dart';

class ReviewHeroTag {
  static String heading(ProductModel product) {
    return "product-${product.id}-appbar-heading";
  }
}
