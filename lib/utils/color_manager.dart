import 'package:flutter/material.dart';

class ColorManager {
  static Color whiteColor = const Color(0xFFffffff);

  static Color mainColor = const Color(0xFF3c9091);
  static Color textColorPrimary = const Color(0xFF38475B);
  static Color colorGrayText = const Color(0xff7A7A7A);
  static Color colorLightGray = const Color(0xffF7F7F7);

  static  MaterialColor myPrimaryMaterialColor = MaterialColor(
    mainColor.value,
    <int, Color>{
      50: const Color(0xFFe8f3f3),
      100: const Color(0xFFc5e2e3),
      200: const Color(0xFF9fcfce),
      300: const Color(0xFF79bcb9),
      400: const Color(0xFF5fa6a3),
      500: ColorManager.mainColor,
      600: const Color(0xFF327c7d),
      700: const Color(0xFF2c6e6f),
      800: const Color(0xFF255f60),
      900: const Color(0xFF1a4243),
    },
  );
}
