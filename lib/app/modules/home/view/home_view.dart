import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [hero(), category()],
        ),
      ),
    );
  }

  Wrap category() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        GestureDetector(
          onTap: () {},
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
          onTap: () {},
          child: const Column(
            children: [
              FaIcon(FontAwesomeIcons.ring),
              Text(
                "Jewelry",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {},
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
          onTap: () {},
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
          onTap: () {},
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
        Expanded(
          child: Container(
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
