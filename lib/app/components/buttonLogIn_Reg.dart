import 'package:flutter/material.dart';

Widget buildLogInAndRegButton(String buttonName, void Function()? func) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return GestureDetector(
        onTap: func,
        child: Container(
          width: constraints.maxWidth,
          height: 50,
          margin: EdgeInsets.only(left: 15, right: 15, top: 40),
          decoration: BoxDecoration(
            color: Color(0xFF12327B),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    },
  );
}
