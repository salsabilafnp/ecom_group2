import 'package:ecom_group2/app/components/bottom_nav_component.dart';
import 'package:ecom_group2/app/components/nav_component.dart';
import 'package:ecom_group2/app/model/product.dart';
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
                  return Card(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.fitHeight,
                                  width: double.infinity,
                                  height: 150,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.isFavorite =
                                        !_controller.isFavorite;
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    _controller.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    size: 17,
                                    color: _controller.isFavorite
                                        ? Colors.red
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text(
                                item.rating.rate.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 13),
                              ),
                              const Icon(
                                Icons.star,
                                size: 13,
                                color: Color(0xffFFFF00),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${item.price}"),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
