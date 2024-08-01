import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        _buildListItem(
          title: 'Mezcal',
          subtitle: 'Para toda mal Mezcal, para todo bien tambien',
          brands: [
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
        _buildListItem(
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
        _buildListItem(
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
        _buildDivider(),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required String subtitle,
    required List<String> brands,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'CircularAirPro',
            fontSize: 30,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Color(0xFFE3FF0A),
          ),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 15),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
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
        const SizedBox(height: 15),
        GestureDetector(
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
