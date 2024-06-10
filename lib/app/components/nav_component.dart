import 'package:ecom_group2/app/modules/favorite/view/favorite_view.dart';
import 'package:ecom_group2/app/modules/home/view/home_view.dart';
import 'package:ecom_group2/app/modules/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavComponent extends StatefulWidget {
  const NavComponent({super.key});

  @override
  State<NavComponent> createState() => _NavComponentState();
}

class _NavComponentState extends State<NavComponent> {
  int _tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: const [
          HomeView(),
          FavoriteView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: changeTabIndex,
      currentIndex: _tabIndex,
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
        )
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required Widget icon, String? label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
