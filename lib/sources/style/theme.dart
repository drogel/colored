import 'package:colored/sources/style/colors.dart' as colors;
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) => ThemeData.from(
      colorScheme: ColorScheme(
        primary: colors.primary,
        primaryVariant: colors.primaryDark,
        secondary: colors.secondary,
        secondaryVariant: colors.secondaryDark,
        surface: colors.secondaryLight,
        background: colors.primary,
        error: colors.error,
        onPrimary: colors.secondary,
        onSecondary: colors.primary,
        onSurface: colors.primaryDark,
        onBackground: colors.secondary,
        onError: colors.secondaryLight,
        brightness: Brightness.light,
      ),
    );
