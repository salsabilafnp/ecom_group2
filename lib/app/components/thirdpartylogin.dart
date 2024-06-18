import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildThirdPartyLogin(BuildContext context) {
  
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;

 
  var containerMarginTop = screenHeight * 0.03;
  var containerMarginBottom = screenHeight * 0.025;
  var containerPadding = screenWidth * 0.075;
  var iconContainerWidth = screenWidth * 0.25;
  var iconContainerHeight = screenHeight * 0.1;
  var iconSize = screenWidth * 0.5;
  



  return Center(
    child: Container(
        margin: EdgeInsets.only(top: containerMarginTop, bottom: containerMarginBottom),
        padding: EdgeInsets.only(left: containerPadding, right: containerPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _reusableIcons("assets/icon/facebook.svg", iconContainerWidth, iconContainerHeight, iconSize),
            _reusableIcons("assets/icon/google.svg", iconContainerWidth, iconContainerHeight, iconSize),
            _reusableIcons("assets/icon/twitter.svg", iconContainerWidth, iconContainerHeight, iconSize)
          ],
        )),
  );
}

Widget _reusableIcons(String path, double width, double height, double iconSize) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE8ECF4),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: SvgPicture.asset(
        path,
        width: iconSize,
        height: iconSize,
      ),
    ),
  );
}
