import 'package:flutter/material.dart';



class FontWightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s9 = 9.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s13 = 13.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s19 = 19.0;
  static const double s20 = 20.0;
  static const double s23 = 23.0;
  static const double s24 = 24.0;
  static const double s25 = 25.0;
  static const double s30 = 30.0;
  static const double s35 = 35.0;

}

class TextStyles {
  static const appNumberTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.w900,
  );

  static const appLabelTextStyle = TextStyle(
    fontSize: 20.0,
    color: Color(0xFF8D8E98),
  );
  static const appTitleTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWightManager.bold,
  );




  static const appBodyTextStyle = TextStyle(
    fontSize: 22.0,
  );
}
