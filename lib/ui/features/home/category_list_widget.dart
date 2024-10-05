import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/ui/features/brand_select/select_a_brand.dart';
import 'package:magueyapp/utils/app_route.dart';
import 'package:provider/provider.dart';

import '../../../entity/category_entity.dart';
import '../../../provider/dashboard_provider.dart';

class CategoryListWidget extends StatefulWidget {
  CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  late List<Category> categories;

  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    categories = dashboardProvider.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Column(
          children: List.generate(categories.length, (index) {
            return Column(
              children: [
                _buildDivider(), //Divisor
                _buildListItem(
                  category: categories[index],
                  onTap: () {
                    AppRoutes.push(context, SelectABrand(category: categories[index]));
                  },
                  heightOfScreen: heightOfScreen,
                  widthOfScreen: widthOfScreen,
                ), //Every list item
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required Category category,
    required VoidCallback onTap,
    required double heightOfScreen,
    required double widthOfScreen,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: heightOfScreen * 0.026667, vertical: widthOfScreen * 0.0488),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widthOfScreen * 0.5,
                      child: AutoSizeText(
                        category.name.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'CircularAirPro',
                          fontSize: heightOfScreen * 0.017,
                          height: heightOfScreen * 0.001750,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFE3FF0A),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: onTap,
                      child: AutoSizeText(
                        'View All ${category.name} Brands',
                        style: TextStyle(
                          fontFamily: 'InstrumentSerif',
                          fontSize: 13,
                          height: heightOfScreen * 0.002333,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF97805F),
                          decorationThickness: 1,
                          decorationColor: const Color(0xFF97805F),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: AutoSizeText(
                    category.shortDescription.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'CircularXXMono',
                      fontSize: heightOfScreen * 0.000962,
                      height: heightOfScreen * 0.001517,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.04,
                      color: const Color(0xFFE2D7C1),
                    ),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF908C00),
      thickness: 0.5,
      height: 30,
    );
  }
}
