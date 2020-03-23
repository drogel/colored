import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/app/styling/fonts.dart' as fonts;
import 'package:colored/sources/app/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) => ThemeData(
      fontFamily: fonts.body,
      primaryColor: colors.primary,
      primaryColorDark: colors.primaryVariant,
      accentColor: colors.secondary,
      colorScheme: const ColorScheme(
        primary: colors.primary,
        primaryVariant: colors.primaryVariant,
        secondary: colors.secondary,
        secondaryVariant: colors.secondaryDark,
        surface: colors.primary,
        background: colors.primary,
        error: colors.errorDark,
        onPrimary: colors.secondary,
        onSecondary: colors.primary,
        onSurface: colors.secondary,
        onBackground: colors.secondary,
        onError: colors.primaryLight,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        body1: TextStyle(color: colors.secondary),
        headline: TextStyle(color: colors.primary),
        subhead: TextStyle(
          color: colors.primaryLight,
          fontFamily: fonts.header,
        ),
        title: TextStyle(color: colors.primaryLight),
        display1: TextStyle(color: colors.primary),
        display3: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: fonts.header,
        ),
      ),
      highlightColor: colors.secondaryDark.withOpacity(opacities.shadow),
      canvasColor: colors.primaryDarkest,
      splashColor: colors.secondary.withOpacity(opacities.fadedColor),
      buttonColor: colors.primaryDark,
      iconTheme: const IconThemeData(color: colors.secondary, size: 32),
    );
