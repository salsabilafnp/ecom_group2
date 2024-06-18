import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_group2/app/components/product_card.dart';
import 'package:ecom_group2/app/modules/product/view/daftar_produk_view.dart';
import 'package:ecom_group2/app/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  final HomeController? controller;

  const HomeView({super.key, this.controller});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController _controller;
  late DateTime targetDateTime;

  final int targetHour = 17;
  final int targetMinute = 0;
  String selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? HomeController();

    final now = DateTime.now();
    targetDateTime =
        DateTime(now.year, now.month, now.day, targetHour, targetMinute);

    // Jika target jam sudah lewat, set ke hari berikutnya
    if (targetDateTime.isBefore(now)) {
      targetDateTime = targetDateTime.add(const Duration(days: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [hero(), category(), allProduct(), flashSale()],
          ),
        ),
      ),
    );
  }

  Future<void> changeCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("category", category);
    print(category);
  }

  Column flashSale() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  const Text("Flash Sale"),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage("https://i.imgur.com/v7yfLh2.png"),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
              CountdownTimer(
                endTime: targetDateTime.millisecondsSinceEpoch,
                textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                onEnd: () {
                  print('Countdown ended');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _controller.fetchProducts("all"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 270.0,
                    initialPage: 0,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.4,
                    padEnds: false,
                  ),
                  items: _controller.products.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
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
                  }).toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Column allProduct() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("New product"),
              InkWell(
                child: const Text("View All"),
                onTap: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _controller.fetchProducts(selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 270.0,
                    initialPage: 0,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.4,
                    padEnds: false,
                  ),
                  items: _controller.products.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
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
                  }).toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Wrap category() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarProdukView()),
            );
            changeCategory("All");
          },
          child: const Column(
            children: [
              Icon(Icons.grid_view),
              Text(
                "All Product",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarProdukView()),
            );
            changeCategory("Jewelery");
          },
          child: const Column(
            children: [
              FaIcon(FontAwesomeIcons.ring),
              Text(
                "Jewelery",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarProdukView()),
            );
            changeCategory("Electronics");
          },
          child: const Column(
            children: [
              Icon(Icons.monitor),
              Text(
                "Electronics",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarProdukView()),
            );
            changeCategory("Men's clothing");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://i.imgur.com/1K994Aa.png"),
                        fit: BoxFit.contain)),
              ),
              // Icon(Icons.grid_view),
              const SizedBox(
                  width: 50,
                  child: Text(
                    "Men's clothing",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarProdukView()),
            );
            changeCategory("Women's clothing");
          },
          child: Column(
            children: [
              Container(
                width: 50,
                height: 30,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://i.imgur.com/a5OwvlN.png"),
                        fit: BoxFit.contain)),
              ),
              // Icon(Icons.grid_view),
              const SizedBox(
                  width: 50,
                  child: Text(
                    "Women's clothing",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Stack hero() {
    return Stack(
      children: [
        Container(
          height: 210,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff00FFA3),
                  Color(0xff42F5E9),
                  Color(0xff3A85E5),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.4, 0.8],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Color(0xFFA1A1A1),
                            hintText: "Search Product",
                            hintStyle: TextStyle(color: Color(0xFFA1A1A1)),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))))),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image:
                              NetworkImage("https://i.imgur.com/rysUiSG.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
