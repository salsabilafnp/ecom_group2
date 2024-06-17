import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return FutureBuilder<bool>(
      future: isLogin(),
      builder: (context, snapshot) {
        // bool isLoggedIn = snapshot.data ?? false;

        return BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: onTabTapped,
          currentIndex: currentIndex,
          elevation: 0,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          items: [
            _bottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            _bottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline),
              label: 'Favorite',
            ),
            // if (isLoggedIn)
            _bottomNavigationBarItem(
              icon: const Icon(Icons.list_alt),
              label: 'Transaction',
            ),
            _bottomNavigationBarItem(
              icon: const FaIcon(
                FontAwesomeIcons.user,
              ),
              label: 'Account',
            ),
          ],
        );
      },
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

  Future<bool> isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? login = prefs.getBool('isLogin') ??
        false; // Dapatkan status login dari SharedPreferences, default ke false jika tidak ada
    return login;
  }
}
