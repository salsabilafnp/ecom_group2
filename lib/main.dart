import 'package:ecom_group2/app/modules/PageView/Page_view.dart';
import 'package:ecom_group2/app/modules/auth/login_authProvider.dart';
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
      child: const MaterialApp(
        home: Welcome(),
      ),
    );
  }
}
