import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecom_group2/app/modules/auth/view/login_view.dart';
import 'package:ecom_group2/app/modules/auth/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc/jbstore_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0; // Tambahkan variabel untuk menyimpan halaman saat ini

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      //color: Color(0xFF12327B),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<JbstoreBloc, JbstoreState>(
          builder: (context, state) {
            if (state is JbstoreLoading) {
              return SplashScreen();
            } else if (state is JbstoreLoaded) {
              return SafeArea(
                child: Container(
                  width: screenWidth,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index; // Perbarui halaman saat ini
                          });
                        },
                        children: [
                          _page(
                            1,
                            context,
                            "Next",
                            "Welcome to JB Store",
                            "Find all your needs from clothing, electronics and other items at the JB store",
                            "assets/icon/ob1.png",
                          ),
                          _page(
                            2,
                            context,
                            "Next",
                            "Welcome to JB Store",
                            "Find all your needs from clothing, electronics and other items at the JB store",
                            "assets/icon/ob2.png",
                          ),
                          _page(
                            3,
                            context,
                            "Get started",
                            "Welcome to JB Store",
                            "Find all your needs from clothing, electronics and other items at the JB store",
                            "assets/icon/ob3.png",
                          ),
                        ],
                      ),
                      Positioned(
                        top: screenHeight *
                            0.53, // Mengatur posisi indicator di atas bagian _page
                        child: DotsIndicator(
                          position: _currentPage,
                          dotsCount: 3,
                          mainAxisAlignment: MainAxisAlignment.center,
                          decorator: DotsDecorator(
                            color: Color(0xFF12327B).withOpacity(0.3),
                            activeSize: const Size(30.0, 8.0),
                            size: const Size.square(8.0),
                            activeColor: Color(0xFF12327B),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subtitle, String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          width: screenWidth >= 450 ? screenWidth * 1 : screenWidth * 0.85,
          height:
              screenHeight >= 900 ? screenHeight * 0.48 : screenHeight * 0.42,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: screenHeight * 0.15),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: screenWidth * 0.95, // Menggunakan 95% dari lebar layar
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(height: screenHeight * 0.16),
        GestureDetector(
          onTap: () {
            //within 0-2 index
            if (index < 3) {
              //animation
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            }
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            width: screenWidth * 0.9, // Menggunakan 80% dari lebar layar
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xFF12327B),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
