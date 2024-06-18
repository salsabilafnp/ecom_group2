import 'package:flutter/material.dart';

enum AppBarType { home, favorite, transaction, detailProduct, cart, profile }

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final AppBarType appBarType;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  const CustomAppbar({
    super.key,
    required this.title,
    this.centerTitle = true,
    required this.appBarType,
    this.isFavorite = false,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    switch (appBarType) {
      case AppBarType.home:
      case AppBarType.favorite:
      case AppBarType.transaction:
        actions = [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            iconSize: 25,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            iconSize: 25,
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ];
        break;
      case AppBarType.detailProduct:
        actions = [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: onFavoritePressed,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ];
        break;
      case AppBarType.cart:
        actions = [];
        break;
      case AppBarType.profile:
        actions = [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
            icon: const Icon(Icons.settings),
          ),
        ];
        break;
    }

    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
