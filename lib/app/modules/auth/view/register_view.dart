import 'package:ecom_group2/app/components/Appbar_login.dart';
import 'package:ecom_group2/app/components/buttonLogIn_Reg.dart';
import 'package:ecom_group2/app/components/textfield_login.dart';
import 'package:ecom_group2/app/components/thirdpartylogin.dart';
import 'package:ecom_group2/app/modules/auth/controller/register_controller.dart';
import 'package:ecom_group2/app/modules/auth/view/login_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppBar("Sign Up", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            ); // Navigasi ke halaman register
          }),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        buildTextField("Username", "user", _usernameController),
                        SizedBox(height: 5),
                        buildTextField("Email", "email", _emailController),
                        SizedBox(height: 5),
                        buildTextField(
                            "Password", "password", _passwordController),
                        SizedBox(height: 5),
                        buildTextField("Confirm Password", "password",
                            _confirmPasswordController),
                      ],
                    ),
                  ),
                ),
                buildLogInAndRegButton("Register", () {
                  if (_formKey.currentState?.validate() == true) {
                    if (_emailController.text.isEmpty ||
                        _usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields')));
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match')));
                    } else {
                      _userController
                          .addUser(
                        _emailController.text,
                        _usernameController.text,
                        _passwordController.text,
                      )
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('User registered successfully!')));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to register user')));
                      });
                    }
                  }
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
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

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
