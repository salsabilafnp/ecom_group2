import 'package:ecom_group2/app/components/Appbar_login.dart';
import 'package:ecom_group2/app/components/buttonLogIn_Reg.dart';
import 'package:ecom_group2/app/components/nav_component.dart';
import 'package:ecom_group2/app/components/textfield_login.dart';
import 'package:ecom_group2/app/components/thirdpartylogin.dart';
import 'package:ecom_group2/app/modules/auth/view/Page_view.dart';
import 'package:ecom_group2/app/modules/auth/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_authProvider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> isLogin(bool login) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", login);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppBar(
            "Sign In",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TitleText("Welcome! Login to"),
                TitleText("JB Store"),
                Container(
                  margin: EdgeInsets.only(top: 36),
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      buildTextField(
                          "Enter your Username", "user", _usernameController),
                      SizedBox(height: 5),
                      buildTextField("Enter your password", "password",
                          _passwordController),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    forgotPassword(),
                  ],
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.isLoggedIn) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavComponent()),
                        );
                        isLogin(true);
                        print("Token: ${authProvider.token}");
                      });
                    }

                    return Column(
                      children: [
                        buildLogInAndRegButton("Log in", () {
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          authProvider.login(username, password);
                        }),
                        if (authProvider.errorMessage != null)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                authProvider.errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: reusableText("Or Register With"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                buildThirdPartyLogin(context),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E232C),
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text(
                    "Register Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF396255),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
