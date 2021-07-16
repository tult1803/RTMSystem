
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color welcome_color = Color.fromARGB(255,11,183,145);
Color button_color = Color.fromARGB(255,254,222,141);
Color buttonDate_color = Color.fromARGB(255,233,231,231);


Color primaryColor = Color(0xFF0bb791);
Color primaryLightColor = Color(0xFF99D5BF);
Color primaryLight2Color = Color(0xFFC7E6C9);
Color primaryLight3Color = Color(0xFF21B6A8);
Color secondaryColor = Color(0xFFF1F7ED);
Color backgroundColor = Color(0xFFEEEEEE);
Color idColor = Color(0xFFf9ee75);
Color lineColor = Color(0xFFBDBDBD);

colorHexa(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}