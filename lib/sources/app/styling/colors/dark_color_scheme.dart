import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/app/styling/colors/colored_color_scheme.dart';
import 'package:flutter/material.dart';

class DarkColorScheme implements ColoredColorScheme {
  const DarkColorScheme();

  @override
  Color get error => colors.error;

  @override
  Color get errorDark => colors.errorDark;

  @override
  Color get primary => colors.primary;

  @override
  Color get primaryDark => colors.primaryDark;

  @override
  Color get primaryDarkest => colors.primaryDarkest;

  @override
  Color get primaryVariant => colors.primaryVariant;

  @override
  Color get secondary => colors.secondary;

  @override
  Color get secondaryDark => colors.secondaryDark;

  @override
  ColorSwatch get swatch => colors.swatch;

  @override
  Color get text => colors.text;

  @override
  Color get textVariant => colors.textVariant;
}
