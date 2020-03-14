import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) => ThemeData(
      fontFamily: "Montserrat",
      primaryColor: colors.primary,
      primaryColorDark: colors.primaryDark,
      colorScheme: ColorScheme(
        primary: colors.primary,
        primaryVariant: colors.primaryDark,
        secondary: colors.secondary,
        secondaryVariant: colors.secondaryDark,
        surface: colors.primary,
        background: colors.primary,
        error: colors.error,
        onPrimary: colors.secondary,
        onSecondary: colors.primary,
        onSurface: colors.secondary,
        onBackground: colors.secondary,
        onError: colors.secondaryLight,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        body1: TextStyle(color: colors.secondary),
        headline: TextStyle(color: colors.secondaryLight),
        subhead: TextStyle(color: colors.secondary, fontFamily: "Oswald"),
        title: TextStyle(color: colors.secondaryLight),
      ),
      iconTheme: IconThemeData(color: colors.secondary, size: 32),
    );
