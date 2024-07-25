import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_up.dart';
import 'package:magueyapp/presentation/catrgory/ui/screen/category_screen.dart';
import 'package:magueyapp/presentation/events/ui/screen/all_events_base_screen.dart';
import 'package:magueyapp/presentation/events/ui/screen/events_details_screen.dart';
import 'package:magueyapp/presentation/favourites/ui/screen/favourites.dart';
import 'package:magueyapp/presentation/filters/ui/screen/filters_screen.dart';
import 'package:magueyapp/presentation/folder_structure_boiler_plate/ui/screen/upload_products.dart';
import 'package:magueyapp/presentation/home/ui/screen/base_screen.dart';
import 'package:magueyapp/presentation/home/ui/screen/home_screen.dart';
import 'package:magueyapp/presentation/privacy_policy/ui/screen/privacy_policy.dart';
import 'package:magueyapp/presentation/product/ui/screen/all_products_screen.dart';
import 'package:magueyapp/presentation/product/ui/screen/product_details_screen.dart';
import 'package:magueyapp/presentation/product/ui/screen/search_products_screen.dart';
import 'package:magueyapp/presentation/profile/ui/screen/profile_screen.dart';
import 'package:magueyapp/presentation/review/ui/screen/add_review_screen.dart';
import 'package:magueyapp/presentation/review/ui/screen/flavor_tags_screen.dart';
import 'package:magueyapp/presentation/search/ui/screen/search_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/all_shops_base_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/all_shops_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/shop_details_screen.dart';
import 'package:magueyapp/presentation/shop/ui/screen/shops_map_view.dart';
import 'package:magueyapp/presentation/auth/ui/screens/reset_password.dart';
import 'package:magueyapp/presentation/auth/ui/screens/sign_in.dart';
import 'package:magueyapp/presentation/splash/ui/screen/splash_screen.dart';

class AppRoutes {
  final Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.route: (_) => const SplashScreen(),
    UploadProductsScreen.route: (_) => const UploadProductsScreen(),
    GetStartedScreen.route: (_) => const GetStartedScreen(),
    SignInScreen.route: (_) => const SignInScreen(),
    SignUpScreen.route: (_) => const SignUpScreen(),
    MyHomePage.route: (_) => const MyHomePage(),
    CategoryScreen.route: (_) => const CategoryScreen(),
    ProductDetailsScreen.route: (_) => const ProductDetailsScreen(),
    AllProductsScreen.route: (_) => const AllProductsScreen(),
    AddReviewScreen.route: (_) => const AddReviewScreen(),
    AddFlavorTagScreen.route: (_) => const AddFlavorTagScreen(),
    BaseScreen.route: (_) => const BaseScreen(),
    ShopDetailsScreen.route: (_) => const ShopDetailsScreen(),
    ProfileScreen.route: (_) => const ProfileScreen(),
    PrivacyPolicy.route: (_) => const PrivacyPolicy(),
    AllShopsMapScreen.route: (_) => const AllShopsMapScreen(),
    AllShopsScreen.route: (_) => const AllShopsScreen(),
    AllShopsBaseScreen.route: (_) => const AllShopsBaseScreen(),
    FavouritesScreen.route: (_) => const FavouritesScreen(),
    FiltersScreen.route: (_) => const FiltersScreen(),
    SearchScreen.route: (_) => const SearchScreen(),
    ResetPasswordScreen.route: (_) => const ResetPasswordScreen(),
    SearchProductsScreen.route: (_) => const SearchProductsScreen(),
    AllEventsBaseScreen.route: (_) => const AllEventsBaseScreen(),
    EventsDetailsScreen.route: (_) => const EventsDetailsScreen(),
  };

  // Animated Push
  Widget returnScreen(String route, {Object? arg}) {
    switch (route) {
      // For Get Start Screen
      case GetStartedScreen.route:
        return const GetStartedScreen();

      // For Sign in screen
      case SignInScreen.route:
        return const SignInScreen();

      // For Sign Up screen
      case SignUpScreen.route:
        return const SignUpScreen();

      // For Reset Password screen
      case ResetPasswordScreen.route:
        return const ResetPasswordScreen();

      // For Homepage screen
      case MyHomePage.route:
        return const MyHomePage();

      // For Base screen
      case BaseScreen.route:
        return const BaseScreen();

      // For Category screen
      case CategoryScreen.route:
        return const CategoryScreen();

      // For All Products screen
      case AllProductsScreen.route:
        return const AllProductsScreen();

      // For All Searched Products screen
      case SearchProductsScreen.route:
        return const SearchProductsScreen();

      // For Product Details screen
      case ProductDetailsScreen.route:
        return const ProductDetailsScreen();

      // For Add Review screen
      case AddReviewScreen.route:
        return const AddReviewScreen();

      // For Add Flavor Tag screen
      case AddFlavorTagScreen.route:
        return const AddFlavorTagScreen();

      // For Shop Details screen
      case ShopDetailsScreen.route:
        return const ShopDetailsScreen();

      // For Profile screen
      case ProfileScreen.route:
        return const ProfileScreen();

      // For Privacy Policy screen
      case PrivacyPolicy.route:
        return const PrivacyPolicy();

      // For Map screen
      case AllShopsMapScreen.route:
        return const AllShopsMapScreen();

      // For All Shops screen
      case AllShopsScreen.route:
        return const AllShopsScreen();

      // For All Shops Base screen
      case AllShopsBaseScreen.route:
        return const AllShopsBaseScreen();

      // For Favourite screen
      case FavouritesScreen.route:
        return const FavouritesScreen();

      // For Filters screen
      case FiltersScreen.route:
        return const FiltersScreen();

      // For Search screen
      case SearchScreen.route:
        return const SearchScreen();

      // For Event screen
      case AllEventsBaseScreen.route:
        return const AllEventsBaseScreen();

      default:
        return Scaffold(
          body: Center(child: Text("No Route with name $route")),
        );
    }
  }
}
