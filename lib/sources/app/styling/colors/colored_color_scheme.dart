import 'package:flutter/material.dart';

abstract class ColoredColorScheme {
  ColorSwatch get swatch;

  Color get primary;

  Color get primaryVariant;

  Color get primaryDark;

  Color get primaryDarkest;

  Color get secondary;

  Color get secondaryDark;

  Color get text;

  Color get textVariant;

  Color get errorDark;

  Color get error;
}
