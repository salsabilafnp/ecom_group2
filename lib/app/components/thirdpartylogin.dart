import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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