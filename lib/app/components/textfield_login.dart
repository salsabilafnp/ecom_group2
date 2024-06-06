import 'package:flutter/material.dart';


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


Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.3),
          fontWeight: FontWeight.normal,
          fontSize: 18),
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


