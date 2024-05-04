import 'package:flutter/material.dart';

class ColorConstants {
  static Color primary = Color.fromARGB(200, 255, 215, 0);
  static Color white = Color.fromARGB(255, 240, 240, 240);
  static Color black = Color.fromARGB(255, 20, 20, 20);
  static Color darkGrey = Color.fromARGB(255, 80, 80, 80);
  static Color grey = Color.fromARGB(255, 120, 120, 120);
  static Color lightGrey = Color.fromARGB(255, 180, 180, 180);
  static Color info = HexColor.fromHex("#0080ff");
  static Color warning = HexColor.fromHex("#ffb74a");
  static Color success = HexColor.fromHex("#0ca85f");
  static Color danger = HexColor.fromHex("#ff5757");
  static Color error = HexColor.fromHex("#e61f34");

  static const MaterialColor swatchPrimary =
      MaterialColor(_swatchprimaryPrimaryValue, <int, Color>{
    50: Color(0xFFE0F3F2),
    100: Color(0xFFB3E2DE),
    200: Color(0xFF80CEC8),
    300: Color(0xFF4DBAB2),
    400: Color(0xFF26ACA2),
    500: Color(_swatchprimaryPrimaryValue),
    600: Color(0xFF009589),
    700: Color(0xFF008B7E),
    800: Color(0xFF008174),
    900: Color(0xFF006F62),
  });
  static const int _swatchprimaryPrimaryValue = 0xFF009D91;

  static const MaterialColor swatchprimaryAccent =
      MaterialColor(_swatchprimaryAccentValue, <int, Color>{
    100: Color(0xFF9EFFF1),
    200: Color(_swatchprimaryAccentValue),
    400: Color(0xFF38FFE2),
    700: Color(0xFF1FFFDE),
  });
  static const int _swatchprimaryAccentValue = 0xFF6BFFE9;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
