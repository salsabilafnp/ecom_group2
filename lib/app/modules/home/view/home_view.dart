import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_group2/app/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      _controller.fetchProducts(selectedCategory).then((_) {
        setState(() {});
      });
    });
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
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
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
                                    const Text(
                                      "4.7",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Color(0xffFFFF00),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$${item.price}"),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 16,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
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
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
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
                                    const Text(
                                      "4.7",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Color(0xffFFFF00),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$${item.price}"),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shopping_cart_outlined,
                                          size: 16,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
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
          onTap: () => changeCategory('all'),
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
          onTap: () => changeCategory('jewelery'),
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
          onTap: () => changeCategory('electronics'),
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
          onTap: () => changeCategory("men's clothing"),
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
          onTap: () => changeCategory("women's clothing"),
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
