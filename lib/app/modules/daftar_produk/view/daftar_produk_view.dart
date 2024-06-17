import 'package:ecom_group2/app/components/bottom_nav_component.dart';
import 'package:ecom_group2/app/components/nav_component.dart';
import 'package:ecom_group2/app/components/product_card.dart';
import 'package:ecom_group2/app/modules/daftar_produk/controller/daftar_produk_controller.dart';
import 'package:flutter/material.dart';

class DaftarProdukView extends StatefulWidget {
  final DaftarProdukController? controller;
  const DaftarProdukView({super.key, this.controller});

  @override
  State<DaftarProdukView> createState() => _DaftarProdukViewState();
}

class _DaftarProdukViewState extends State<DaftarProdukView> {
  late DaftarProdukController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DaftarProdukController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [title(), list()],
        ),
      ),
      bottomNavigationBar: BottomNavComponent(
        currentIndex: 0,
        onTabTapped: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavComponent(),
            ),
            (route) => false,
          );
        },
      ),
    );
  }

  Expanded list() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
          future: _controller.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2.6 / 4,
                ),
                itemCount: _controller.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _controller.products[index];
                  return ProductCard(
                    productId: item.id,
                    imageUrl: item.image,
                    title: item.title,
                    rating: item.rating.rate,
                    price: item.price,
                    isFavorite: _controller.isFavorite,
                    onFavoriteToggle: () {
                      setState(() {
                        _controller.isFavorite = !_controller.isFavorite;
                      });
                    },
                    onCardTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail-produk',
                        arguments: item.id,
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Padding title() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder<String>(
                        future: _controller.getData(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error: ${snapshot.error}'); // Show error message if fetching data fails
                          } else {
                            return Text(
                              snapshot.data ?? '', // Display the fetched data
                              style: const TextStyle(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
          ],
        ));
  }
}
