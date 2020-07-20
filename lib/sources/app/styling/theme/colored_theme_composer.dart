import 'package:colored/sources/app/styling/colors/colored_color_scheme.dart';
import 'package:colored/sources/app/styling/elevation/elevation_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/theme/theme_composer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColoredThemeComposer implements ThemeComposer {
  const ColoredThemeComposer({
    @required this.colors,
    @required this.opacity,
    @required this.fonts,
    @required this.elevation,
  })  : assert(colors != null),
        assert(fonts != null),
        assert(opacity != null);

  final ColoredColorScheme colors;
  final OpacityScheme opacity;
  final FontScheme fonts;
  final ElevationScheme elevation;

  @override
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
        textSelectionColor: colors.secondaryDark,
        hintColor: colors.textVariant,
        hoverColor: colors.secondaryDark.withOpacity(opacity.hover),
        colorScheme: ColorScheme(
          primary: colors.primary,
          primaryVariant: colors.primaryVariant,
          secondary: colors.secondary,
          secondaryVariant: colors.secondaryDark,
          surface: colors.primary,
          background: colors.primary,
          error: colors.error,
          onPrimary: colors.secondary,
          onSecondary: colors.primary,
          onSurface: colors.secondary,
          onBackground: colors.secondary,
          onError: colors.text,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          elevation: elevation.medium,
          color: colors.primary,
          actionsIconTheme: IconThemeData(color: colors.text),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: colors.text),
          bodyText1: TextStyle(color: colors.text),
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
        canvasColor: colors.primaryVariant,
        splashColor: colors.secondary.withOpacity(opacity.fadedColor),
        buttonColor: colors.primaryDark,
        disabledColor: colors.primary,
        iconTheme: IconThemeData(color: colors.secondary, size: 32),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: elevation.medium,
          backgroundColor: colors.primary,
          selectedItemColor: colors.text,
          unselectedItemColor: colors.textVariant,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: colors.secondary,
          primaryContrastingColor: colors.primary,
          scaffoldBackgroundColor: colors.primary,
          barBackgroundColor: colors.primary,
        ),
      );
}
