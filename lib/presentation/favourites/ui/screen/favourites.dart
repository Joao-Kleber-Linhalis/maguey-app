import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';

class FavouritesScreen extends StatefulWidget {
  static const String route = "favourites";
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TitledAppBar(title: "Favourites", showBackButton: false),
      body: Center(child: Text("Coming Soon")),
    );
  }
}
