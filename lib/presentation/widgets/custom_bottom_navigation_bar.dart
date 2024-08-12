import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, //store.state.currentBtmIndex,
      onTap: (index) {
        //store.dispatch(NavigationAction(index: index));
      },
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
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'CircularXXMono',
        fontSize: 12,
        letterSpacing: 0.2,
        color: Colors.grey,
      ),
      type: BottomNavigationBarType.fixed,
    );
  }
}
