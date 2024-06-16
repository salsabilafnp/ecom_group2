import 'package:ecom_group2/app/components/bottom_nav_component.dart';
import 'package:flutter/material.dart';
import 'package:ecom_group2/app/modules/favorite/view/favorite_view.dart';
import 'package:ecom_group2/app/modules/home/view/home_view.dart';
import 'package:ecom_group2/app/modules/profile/view/profile_view.dart';

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
      bottomNavigationBar: BottomNavComponent(
        currentIndex: _tabIndex,
        onTabTapped: changeTabIndex,
      ),
    );
  }
}
