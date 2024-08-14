import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/product/product_list/product_list_screen.dart';
import 'package:magueyapp/utils/responsive/responsive.dart';

import '../../../brand_select/ui/screen/brand_select_screen.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        ListItemWidget(
          title: 'Mezcal',
          subtitle: 'Para toda mal Mezcal, para todo bien tambien',
          brands: const [
            'AGUA MAGICA',
            'PAPALOTE',
            'BOZAL',
            'EL PINTOR',
            'LAX',
            'DEL MAGUEY',
            'VIDA',
            'MADRE',
            'EL SILENCIO',
            'ILEGAL',
            'MONTELOBOS',
            'ROSALUNA',
            'BANHEZ',
          ],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProductListScreen(),
            ));
          },
        ),
        _buildDivider(),
        ListItemWidget(
          title: 'Raicilla',
          subtitle: 'Distinct as a cactus flower in the desert',
          brands: const [
            '400 CONEJOS',
            'PAPALOTE',
            'BOZAL',
            'EL PINTOR',
            'LAX',
            'DEL MAGUEY',
            'VIDA',
            'MADRE',
            'EL SILENCIO',
            'ILEGAL',
            'MONTELOBOS',
            'ROSALUNA',
            'BANHEZ',
          ],
          onTap: () {},
        ),
        _buildDivider(),
        ListItemWidget(
          title: 'Sotol',
          subtitle: 'A visit from the ancestral spirits',
          brands: const [
            '400 CONEJOS',
            'PAPALOTE',
            'BOZAL',
            'EL PINTOR',
            'LAX',
            'DEL MAGUEY',
            'VIDA',
            'MADRE',
            'EL SILENCIO',
            'ILEGAL',
            'MONTELOBOS',
            'ROSALUNA',
            'BANHEZ',
          ],
          onTap: () {},
        ),
      ],
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

class ListItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> brands;
  final VoidCallback onTap;

  const ListItemWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.brands,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightOfScreen = Responsive.heightOfScreen(context);
    List<String> brandList = brands.map(
      (brand) {
        return '$brand   ';
      },
    ).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: heightOfScreen * 0.046667),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BrandSelectScreen(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      fontFamily: 'CircularAirPro',
                      fontSize: 30,
                      height: heightOfScreen * 0.0011,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFE3FF0A),
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'InstrumentSerif',
                      fontSize: 13,
                      height: heightOfScreen * 0.001517,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF908C00),
                    ),
                    // maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: heightOfScreen * 0.0175),
            Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'CircularXXMono',
                    fontSize: 13,
                    height: 2.5,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.05,
                    color:Color(0xFFE2D7C1),
                  ),
                  children: brandList
                      .map(
                        (brand) => TextSpan(
                          text: brand 
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: heightOfScreen * 0.0175),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onTap,
                child: AutoSizeText(
                  'View All $title Brands',
                  style: TextStyle(
                    fontFamily: 'InstrumentSerif',
                    fontSize: 15,
                    height: heightOfScreen * 0.002333,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF97805F),
                    decorationThickness: 1,
                    decorationColor: const Color(0xFF97805F),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
