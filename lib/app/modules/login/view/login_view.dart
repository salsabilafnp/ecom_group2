import 'package:ecom_group2/app/components/textfield_login.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppBar(context),
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
                      buildTextField("Enter your email", "email"),
                      SizedBox(height: 5),
                      buildTextField("Enter your password", "password")
                    ],
                  ),
                ),
                // Row with Spacer to position forgotPassword() to the right
                Row(
                  children: [
                    Spacer(),
                    forgotPassword(),
                  ],
                ),
                buildLogInAndRegButton("Log in", () {
                  print("Login button");
                }),
                SizedBox(height: 30),
                Center(child: reusableText("Or Login With")),
                buildThirdPartyLogin(context)
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}