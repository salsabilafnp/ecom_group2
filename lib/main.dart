import 'package:ecom_group2/app/components/nav_component.dart';
import 'package:ecom_group2/app/modules/auth/controller/bloc/jbstore_bloc.dart';
import 'package:ecom_group2/app/modules/auth/login_authProvider.dart';
import 'package:ecom_group2/app/modules/cart/controller/cart_controller.dart';
import 'package:ecom_group2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_group2/app/modules/daftar_produk/view/detail_produk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: BlocProvider(
        create: (context) => JbstoreBloc()..add(OnJbstoreCalled()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const NavComponent(),
          routes: {
            '/detail-produk': (ctx) => DetailProductView(
                  productId: ModalRoute.of(ctx)?.settings.arguments as int,
                ),
            '/cart': (ctx) => const CartView(),
          },
        ),
      ),
    );
  }
}
