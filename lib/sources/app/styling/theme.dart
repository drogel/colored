import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/app/styling/fonts.dart' as fonts;
import 'package:colored/sources/app/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) => ThemeData(
      fontFamily: fonts.body,
      primaryColor: colors.primary,
      primaryColorDark: colors.primaryVariant,
      accentColor: colors.secondary,
      scaffoldBackgroundColor: colors.primaryLight,
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
        onError: colors.text,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 2,
        color: colors.primary,
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: colors.secondary),
        headline5: TextStyle(color: colors.primary),
        subtitle1: TextStyle(
          color: colors.text,
          fontFamily: fonts.header,
        ),
        headline6: TextStyle(color: colors.text),
        headline4: TextStyle(color: colors.primary),
        headline2: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: fonts.header,
        ),
        caption: TextStyle(color: colors.text),
      ),
      highlightColor: colors.secondaryDark.withOpacity(opacities.shadow),
      canvasColor: colors.primaryDarkest,
      splashColor: colors.secondary.withOpacity(opacities.fadedColor),
      buttonColor: colors.primaryDark,
      iconTheme: const IconThemeData(color: colors.secondary, size: 32),
    );
