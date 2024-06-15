import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavComponent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavComponent({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: onTabTapped,
      currentIndex: currentIndex,
      elevation: 0,
      items: [
        _bottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          label: 'Favorite',
        ),
        _bottomNavigationBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.user,
          ),
          label: 'Account',
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required Widget icon,
    String? label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
