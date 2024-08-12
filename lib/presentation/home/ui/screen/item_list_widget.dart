import 'package:flutter/material.dart';

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
          onTap: () {},
        ),
        _buildDivider(),
        ListItemWidget(
          title: 'Raicilla',
          subtitle: 'Distinct as a cactus flower in the desert',
          brands: [
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
          brands: [
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrandSelectScreen(),
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
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'CircularAirPro',
                      fontSize: 30,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFE3FF0A),
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'InstrumentSerif',
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF908C00),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 13.5,
                runSpacing: 8.0,
                children: brands
                    .map(
                      (brand) => Text(
                        brand,
                        style: const TextStyle(
                          fontFamily: 'CircularXXMono',
                          fontSize: 13,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.05,
                          color: Color(0xFFE2D7C1),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  'View All $title Brands',
                  style: const TextStyle(
                    fontFamily: 'InstrumentSerif',
                    fontSize: 15,
                    height: 2.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF97805F),
                    decorationThickness: 1,
                    decorationColor: Color(0xFF97805F),
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
