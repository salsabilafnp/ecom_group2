import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 60,
    flexibleSpace: Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF12327B), // Warna berdasarkan kode hexa
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              // Tambahkan fungsi untuk menangani ketika tombol silang ditekan
            },
            padding: EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget TitleText(String text) {
  return Container(
    margin: EdgeInsets.only(
      left: 20,
    ),
    child: Text(
      text,
      style: TextStyle(
          color: Color(0xFF114232), fontWeight: FontWeight.bold, fontSize: 40),
    ),
  );
}

//need context for accesing bloc
Widget buildThirdPartyLogin(BuildContext context) {
  return Center(
    child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _reusableIcons("assets/icon/facebook.svg"),
            _reusableIcons("assets/icon/google.svg"),
            _reusableIcons("assets/icon/twitter.svg")
          ],
        )),
  );
}

Widget _reusableIcons(String path) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color:Color(0xFFE8ECF4),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: SvgPicture.asset(
        path,
        width: 30, // Atur lebar SVG sesuai kebutuhan Anda
        height: 30, // Atur tinggi SVG sesuai kebutuhan Anda
      ),
    ),
  );
}

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.normal,
          fontSize: 14),
    ),
  );
}

Widget buildTextField(String hintText, String textType) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        // Lebar container menyesuaikan dengan 90% lebar parent
        width: constraints.maxWidth * 1,
        height: 50,
        margin: EdgeInsets.only(bottom: 20, left: 0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F7),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Color(0xFFEBEDF0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                height: 70,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle:
                        TextStyle(color: Color(0xFFB3B9C4), fontSize: 14),
                  ),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  autocorrect: false,
                  obscureText: textType == "password",
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget forgotPassword() {
  return Container(
    margin: EdgeInsets.only(right: 25),
    height: 44,
    child: GestureDetector(
      onTap: () {},
      child: Text(
        "Forgot password?",
        style: TextStyle(
            color: Color(0xFFC2C7D0),
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buildLogInAndRegButton(
    String buttonName, void Function()? func) {
  return LayoutBuilder(builder: (context, constraints){
    return GestureDetector(
    onTap: () => func,
    child: Container(
      width: constraints.maxWidth * 1,
      height: 50,
      margin: EdgeInsets.only(
          left: 15, right: 15, top: 40),
      decoration: BoxDecoration(
          color:Color(0xFF12327B),
          borderRadius: BorderRadius.circular(30),
          ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color:  Colors.white),
        ),
      ),
    ),
  );
  });
}
