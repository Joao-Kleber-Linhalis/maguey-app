import 'package:flutter/material.dart';
import 'package:magueyapp/service/custom_bottom_navigation_bar_service.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final store = CustomBottomNavigationBarService.instance;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: store.setCurrentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'MAP',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'EVENTS',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'ME',
            ),
          ],
          backgroundColor: const Color(0xFF2B2B2B),
          selectedItemColor: const Color(0xFFE3FF0A),
          unselectedItemColor: const Color(0xFF908C00),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'CircularXXMono',
            fontSize: 12,
            letterSpacing: 0.2,
            color: Color(0xFFE6E54A),
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFFE6E54A),
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'CircularXXMono',
            fontSize: 12,
            letterSpacing: 0.2,
            color: Colors.grey,
          ),
          type: BottomNavigationBarType.fixed,
        );
      },
    );
  }
}
