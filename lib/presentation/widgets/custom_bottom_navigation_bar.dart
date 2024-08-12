import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/presentation/home/redux/home_actions.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<HomeState>(
      builder: (context, store) {
        return BottomNavigationBar(
          currentIndex: store.state.currentBtmIndex,
          onTap: (index) {
            store.dispatch(NavigationAction(index: index));
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
      },
    );
  }
}
