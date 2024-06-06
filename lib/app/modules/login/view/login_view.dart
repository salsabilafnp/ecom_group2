import 'package:ecom_group2/app/components/Appbar_login.dart';
import 'package:ecom_group2/app/components/buttonLogIn_Reg.dart';
import 'package:ecom_group2/app/components/textfield_login.dart';
import 'package:ecom_group2/app/components/thirdpartylogin.dart';
import 'package:ecom_group2/app/modules/register/view/Register_view.dart';
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
          appBar: buildAppBar(
            "Sign In",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
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
                buildThirdPartyLogin(context)
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
                    
                    print("Navigate to Register Page");
                    // Anda bisa menambahkan navigasi ke halaman pendaftaran di sini
                     Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
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
