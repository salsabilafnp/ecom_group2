import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(18, 50, 123, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "JB STORE",
                style:
                    GoogleFonts.irishGrover(fontSize: 40, color: Colors.white),
              ).animate().fade(delay: const Duration(milliseconds: 500)),
              const SizedBox(
                height: 20,
              ),
              LottieBuilder.asset(
                "assets/animation-screen.json",
                width: 270,
              )
            ],
          ),
        ),
      ),
    );
  }
}
