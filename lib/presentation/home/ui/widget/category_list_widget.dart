import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  final List<String> categorys = const [ //Lista de categorias mockadas por agora
    "Agave",
    "Bacanora",
    "Mezcal",
    "Raicilla",
    "Sotol",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(categorys.length, (index) { //Gerador de item da lista
            return Column(
              children: [
                _buildDivider(), //Divisor
                _buildListItem(title: categorys[index], onTap: () {}), //Cada item da lista
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildListItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap, //On Tap para redirecionamento 
            child: Text( //Titulo maior a esquerda
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
          Text( // "sub-titulo" a  direita
            "A BLURB ABOUT ${title.toUpperCase()} HERE",
            style: const TextStyle(
              fontFamily: 'CircularXXMono',
              fontSize: 12.5,
              height: 1.3,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.04,
              color: Color(0xFFE2D7C1),
            ),
          ),
        ],
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
