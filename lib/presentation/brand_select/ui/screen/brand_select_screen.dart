import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/product_select/ui/product_select_screen.dart';
import 'package:magueyapp/theme/my_colors.dart';
import '../../../../theme/my_icons.dart';

import '../../../../theme/text_styling.dart';
import '../../../widgets/custom_bottom_navigation_bar.dart';

final textStyles = TextStyleCustom();

class BrandSelectScreen extends StatelessWidget {
  static const String route = 'brand-select';

  const BrandSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                MyIcons.brandIcon, // Replace with your logo
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
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
                          'MEZCAL',
                          style: textStyles.font_10w400Black.copyWith(
                            color: MyColors.brown97805F,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            decoration: TextDecoration.underline,
                            decorationColor: MyColors.brown97805F,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Agua Magica',
                          style: textStyles.font_28w700Black.copyWith(
                            color: const Color(0xFFE3FF0A), // Yellow text color
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/temp/agua_magica.jpeg', // Replace with your actual image
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'San Juan del Río, Oaxaca, Mexico',
                          style: textStyles.font_13w300.copyWith(
                            fontWeight: FontWeight.w400,
                            color: MyColors.brown97805F,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'An award-winning and ultra-premium sipping mezcal handcrafted from 7-15 year old agaves, that offers a crisp, smooth, and flavorful experience, inspiring the palate with its complex layers.',
                          style: textStyles.font_16w500Black.copyWith(
                            color: const Color(0xFFE2D7C1),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Nose: Unique blend of cooked maguey, with vague notes of smoke, bananas, and almonds.',
                          style: textStyles.font_16w500Black.copyWith(
                            color: const Color(0xFFE2D7C1),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Taste: Smooth on the palate. Feels fresh with a slightly spicy flavor, as if drinking water from the river. Sweet notes with clove, caramel, banana, almonds, and peach essence.',
                          style: textStyles.font_16w500Black.copyWith(
                            color: const Color(0xFFE2D7C1),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ProductSelectScreen(),
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
