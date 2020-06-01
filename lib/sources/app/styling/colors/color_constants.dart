import 'package:flutter/material.dart';

final ColorSwatch swatch = MaterialColor(secondary.value, {
  50: secondary.withOpacity(0.2),
  100: secondary.withOpacity(0.4),
  200: secondary.withOpacity(0.6),
  300: secondary.withOpacity(0.8),
  400: secondary.withOpacity(1),
  500: secondaryDark.withOpacity(0.2),
  600: secondaryDark.withOpacity(0.4),
  700: secondaryDark.withOpacity(0.6),
  800: secondaryDark.withOpacity(0.8),
  900: secondaryDark.withOpacity(1),
});

const Color primary = Color.fromRGBO(48, 48, 48, 1);
const Color primaryVariant = Color.fromRGBO(33, 33, 33, 1);
const Color primaryDark = Color.fromRGBO(26, 26, 26, 1);
const Color primaryDarkest = Color.fromRGBO(15, 15, 15, 1);

const Color secondary = Color.fromRGBO(128, 203, 196, 1);
const Color secondaryDark = Color.fromRGBO(88, 124, 121, 1);

const Color text = Color.fromRGBO(250, 253, 252, 1);
const Color textVariant = Color.fromRGBO(163, 166, 165, 1);

const Color errorDark = Color.fromRGBO(102, 35, 37, 1);
const Color error = Color.fromRGBO(252, 86, 89, 1);

final Color blue = Colors.blueAccent[700];
final Color red = Colors.redAccent[700];
final Color green = Colors.lightGreenAccent[700];

const Color logoBlue = Color.fromRGBO(192, 229, 225, 1);
const Color logoRed = Color.fromRGBO(250, 171, 173, 1);
const Color logoGray = Color.fromRGBO(149, 149, 149, 1);
