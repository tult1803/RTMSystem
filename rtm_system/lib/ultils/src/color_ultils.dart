
import 'package:flutter/cupertino.dart';

Color welcome_color = Color.fromARGB(255,11,183,145);
Color button_color = Color.fromARGB(255,254,222,141);
Color buttonDate_color = Color.fromARGB(255,233,231,231);

colorHexa(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}