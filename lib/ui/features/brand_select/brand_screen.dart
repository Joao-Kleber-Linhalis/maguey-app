import 'package:flutter/material.dart';

import '../../../custom_app_bar.dart';
import '../../../entity/brand_entity.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/text_styling.dart';
import '../product/product_list/product_list_screen.dart';

final textStyles = TextStyleCustom();

class BrandScreen extends StatelessWidget {
  final Brand brand;
  final String categoryName;
  static const String route = 'brand-select';

  const BrandScreen({
    Key? key,
    required this.brand,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: const CustomAppBar(goesBack: true),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName.toUpperCase(),
                          style: textStyles.font_14w400.copyWith(
                            color: MyColors.brown97805F,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            decoration: TextDecoration.underline,
                            decorationColor: MyColors.brown97805F,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          brand.name,
                          style: textStyles.font_28w700Black.copyWith(
                            color: const Color(0xFFE3FF0A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.width - 100,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Image.network(brand.image, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${brand.city}, ${brand.state}, ${brand.country}',
                          style: textStyles.font_13w300.copyWith(
                            fontWeight: FontWeight.w400,
                            color: MyColors.brown97805F,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          brand.description,
                          style: textStyles.font_12w400.copyWith(
                            color: const Color(0xFFE2D7C1),
                            height: 1.5,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ProductListScreen(brandId: brand.id, categoryName: categoryName),
                              ),
                            );
                          },
                          child: Text(
                            'View Products',
                            style: textStyles.font_13w300.copyWith(
                              color: MyColors.brown97805F,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: MyColors.brown97805F,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
