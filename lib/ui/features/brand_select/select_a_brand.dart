import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../custom_app_bar.dart';
import '../../../entity/brand_entity.dart';
import '../../../entity/category_entity.dart';
import '../../../provider/dashboard_provider.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/text_styling.dart';
import '../../../utils/app_route.dart';
import '../events/add_a_event.dart';
import 'brand_screen.dart';

final textStyles = TextStyleCustom();

class SelectABrand extends StatefulWidget {
  final Category category;
  static const String route = 'brand-select';

  const SelectABrand({Key? key, required this.category}) : super(key: key);

  @override
  State<SelectABrand> createState() => _SelectABrandState();
}

class _SelectABrandState extends State<SelectABrand> {
  TextEditingController controller = TextEditingController();
  late List<Brand> brands;
  late List<Brand> filteredBrands;

  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    brands = dashboardProvider.brands;
    filteredBrands = brands.where((element) => element.categoryId == widget.category.id).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.black2B2B2B,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Search within, let the Spirits speak to you',
                controller: controller,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    filteredBrands = brands.where((brand) {
                      return brand.name.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBrands.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AppRoutes.push(
                          context,
                          BrandScreen(
                            brand: filteredBrands[index],
                            categoryName: widget.category.name,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              filteredBrands[index].name,
                              style: textStyles.font_28w700Black.copyWith(
                                color: const Color(0xFFE3FF0A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(filteredBrands[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
