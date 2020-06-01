import 'package:colored/sources/app/styling/colors/colored_color_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColoredThemeWrapper {
  const ColoredThemeWrapper({
    @required this.colors,
    @required this.opacity,
    @required this.fonts,
  })  : assert(colors != null),
        assert(fonts != null),
        assert(opacity != null);

  final ColoredColorScheme colors;
  final OpacityScheme opacity;
  final FontScheme fonts;

  ThemeData getThemeData() => ThemeData(
        fontFamily: fonts.primary,
        primaryColor: colors.primary,
        primaryColorDark: colors.primaryVariant,
        accentColor: colors.secondary,
        scaffoldBackgroundColor: colors.primary,
        cursorColor: colors.secondary,
        indicatorColor: colors.secondary,
        primarySwatch: colors.swatch,
        textSelectionHandleColor: colors.secondary,
        hintColor: colors.textVariant,
        colorScheme: ColorScheme(
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
        appBarTheme: AppBarTheme(
          elevation: 6,
          color: colors.primary,
          actionsIconTheme: IconThemeData(color: colors.text),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: colors.text),
          headline5: TextStyle(color: colors.primary),
          subtitle1: TextStyle(color: colors.text, fontFamily: fonts.secondary),
          headline6: TextStyle(color: colors.text),
          headline4: TextStyle(color: colors.primary),
          headline2: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: fonts.secondary,
          ),
          caption: TextStyle(color: colors.textVariant),
        ),
        highlightColor: colors.secondaryDark.withOpacity(opacity.shadow),
        canvasColor: colors.textVariant,
        splashColor: colors.secondary.withOpacity(opacity.fadedColor),
        buttonColor: colors.primaryDark,
        iconTheme: IconThemeData(color: colors.secondary, size: 32),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: colors.secondary,
          primaryContrastingColor: colors.primary,
          scaffoldBackgroundColor: colors.primary,
          barBackgroundColor: colors.primary,
        ),
      );
}
