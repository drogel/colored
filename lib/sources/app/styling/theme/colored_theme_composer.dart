import 'package:colored/sources/app/styling/colors/colored_color_scheme.dart';
import 'package:colored/sources/app/styling/elevation/elevation_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/theme/theme_composer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColoredThemeComposer implements ThemeComposer {
  const ColoredThemeComposer({
    required this.colors,
    required this.opacity,
    required this.fonts,
    required this.elevation,
  });

  final ColoredColorScheme colors;
  final OpacityScheme opacity;
  final FontScheme fonts;
  final ElevationScheme elevation;

  @override
  ThemeData getThemeData() => ThemeData(
        fontFamily: fonts.primary,
        primaryColor: colors.primary,
        primaryColorDark: colors.primaryVariant,
        scaffoldBackgroundColor: colors.primary,
        indicatorColor: colors.secondary,
        focusColor: colors.primaryDark,
        primarySwatch: colors.swatch as MaterialColor?,
        hintColor: colors.textVariant,
        hoverColor: colors.secondaryDark.withOpacity(opacity.hover),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colors.secondary,
          selectionHandleColor: colors.secondary,
          selectionColor: colors.secondaryDark,
        ),
        colorScheme: ColorScheme(
          primary: colors.primary,
          primaryContainer: colors.primaryVariant,
          secondary: colors.secondary,
          secondaryContainer: colors.secondaryDark,
          surface: colors.primary,
          background: colors.primary,
          error: colors.error,
          onPrimary: colors.secondary,
          onSecondary: colors.primary,
          onSurface: colors.text,
          onBackground: colors.secondary,
          onError: colors.text,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          elevation: elevation.low,
          color: colors.primary,
          actionsIconTheme: IconThemeData(color: colors.text),
          iconTheme: IconThemeData(color: colors.text),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: colors.text),
          bodyText1: TextStyle(color: colors.text),
          headline5: TextStyle(color: colors.primary),
          subtitle1: TextStyle(color: colors.text, fontFamily: fonts.secondary),
          headline6: TextStyle(color: colors.text),
          headline4: TextStyle(color: colors.primary),
          headline3: TextStyle(
            color: colors.text,
            fontFamily: fonts.secondary,
          ),
          headline2: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: fonts.secondary,
          ),
          caption: TextStyle(color: colors.textVariant, fontSize: 10),
        ),
        highlightColor: colors.secondaryDark.withOpacity(opacity.shadow),
        canvasColor: colors.primaryVariant,
        splashColor: colors.secondary.withOpacity(opacity.fadedColor),
        disabledColor: colors.primary,
        iconTheme: IconThemeData(color: colors.secondary, size: 32),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: elevation.medium,
          backgroundColor: colors.primary,
          selectedItemColor: colors.text,
          unselectedItemColor: colors.textVariant,
        ),
        navigationRailTheme: NavigationRailThemeData(
          elevation: 0,
          backgroundColor: colors.primary,
          selectedIconTheme: IconThemeData(color: colors.text),
          unselectedIconTheme: IconThemeData(color: colors.textVariant),
          selectedLabelTextStyle: TextStyle(color: colors.text),
          unselectedLabelTextStyle: TextStyle(color: colors.textVariant),
        ),
        dividerTheme: DividerThemeData(
          color: colors.primaryVariant,
          thickness: 1,
          space: 1,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: colors.secondary,
          primaryContrastingColor: colors.primary,
          scaffoldBackgroundColor: colors.primary,
          barBackgroundColor: colors.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: colors.primaryDark,
            onPrimary: colors.secondary,
          ),
        ),
        visualDensity: VisualDensity.standard,
      );
}
