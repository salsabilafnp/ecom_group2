import 'package:ecom_group2/app/components/Appbar_login.dart';
import 'package:ecom_group2/app/components/buttonLogIn_Reg.dart';
import 'package:ecom_group2/app/components/textfield_login.dart';
import 'package:ecom_group2/app/components/thirdpartylogin.dart';
import 'package:ecom_group2/app/modules/login/view/login_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppBar("Sign Up",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              ); // Navigasi ke halaman register
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TitleText("Hello! Register to get"),
                TitleText("Started"),
                Container(
                  margin: EdgeInsets.only(top: 36),
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      buildTextField("Username", "user"),
                      SizedBox(height: 5),
                      buildTextField("Email", "email"),
                      SizedBox(height: 5),
                      buildTextField("Password", "password"),
                      SizedBox(height: 5),
                      buildTextField("Confirm Password", "password"),
                    ],
                  ),
                ),
      
                buildLogInAndRegButton("Register", () {
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
                        child: reusableText("Or Login With"),
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
                  "Already have an account?",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  child: Text(
                    "Login Now",
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