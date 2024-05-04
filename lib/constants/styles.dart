import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamilay,
      color: color,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSizes.s14,
    Color color = const Color.fromARGB(255, 240, 240, 240)}) {
  return _getTextStyle(fontSize, FontWeights.regular, color);
}

//bold text style
TextStyle getBoldStyle(
    {double fontSize = FontSizes.s14,
    Color color = const Color.fromARGB(255, 240, 240, 240)}) {
  return _getTextStyle(fontSize, FontWeights.bold, color);
}
