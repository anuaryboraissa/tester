import 'package:flutter/material.dart';

class ApplicationStyles {
  static const Color appColor = Color.fromARGB(248, 86, 96, 231);
  static const Color activeBottomBarColor = Color.fromARGB(255, 240, 114, 5);
  static const Color inactiveOnboardingPageColor =
      Color.fromRGBO(249, 168, 37, 1);
  static const Color backgroundColor = Color.fromARGB(0, 248, 245, 244);
  static const Color inputColor = Color.fromARGB(255, 222, 236, 247);
  static const Color cardsColor = Color.fromARGB(237, 4, 4, 32);
  static const Color realAppColor = Color(0xFF0081A0);

  static const int applicationMargin = 25;

  static TextStyle getStyle(bool bold, double? fontSize, Color? color) {
    return TextStyle(
      color: color,
      fontFamily: "Popins",
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static double getScreenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(context) {
    return MediaQuery.of(context).size.height;
  }
}
