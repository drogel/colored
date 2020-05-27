import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/app/styling/fonts.dart' as fonts;
import 'package:colored/sources/app/styling/opacities.dart' as opacities;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) => ThemeData(
      fontFamily: fonts.body,
      primaryColor: colors.primary,
      primaryColorDark: colors.primaryVariant,
      accentColor: colors.secondary,
      scaffoldBackgroundColor: colors.primary,
      cursorColor: colors.secondary,
      indicatorColor: colors.secondary,
      primarySwatch: colors.swatch,
      textSelectionHandleColor: colors.secondary,
      hintColor: colors.textVariant,
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
        elevation: 6,
        color: colors.primary,
        actionsIconTheme: IconThemeData(color: colors.text),
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: colors.secondary),
        headline5: TextStyle(color: colors.primary),
        subtitle1: TextStyle(color: colors.text, fontFamily: fonts.header),
        headline6: TextStyle(color: colors.text),
        headline4: TextStyle(color: colors.primary),
        headline2: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: fonts.header,
        ),
        caption: TextStyle(color: colors.textVariant),
      ),
      highlightColor: colors.secondaryDark.withOpacity(opacities.shadow),
      canvasColor: colors.textVariant,
      splashColor: colors.secondary.withOpacity(opacities.fadedColor),
      buttonColor: colors.primaryDark,
      iconTheme: const IconThemeData(color: colors.secondary, size: 32),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: colors.secondary,
        primaryContrastingColor: colors.primary,
        scaffoldBackgroundColor: colors.primary,
        barBackgroundColor: colors.primary,
      ),
    );
