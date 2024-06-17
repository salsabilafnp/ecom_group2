import 'package:ecom_group2/app/components/nav_component.dart';
import 'package:ecom_group2/app/modules/auth/login_authProvider.dart';
import 'package:ecom_group2/app/modules/daftar_produk/view/detail_produk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: "JB Store App",
        home: const NavComponent(),
        routes: {
          '/detail-produk': (ctx) => DetailProductView(
                productId: ModalRoute.of(ctx)?.settings.arguments as int,
              ),
        },
      ),
    );
  }
}
