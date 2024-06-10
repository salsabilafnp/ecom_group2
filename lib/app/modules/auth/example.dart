import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/bloc/jbstore_bloc.dart';
import 'view/splash_screen.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<JbstoreBloc, JbstoreState>(
        builder: (context, state) {
          if (state is JbstoreLoading) {
            return const SplashScreen();
          }
          return const Center(
            child: Text("HALAMAN LOGIN"),
          );
        },
      ),
    );
  }
}
