import 'package:colored/sources/app/styling/theme/colored_theme_composer.dart';
import 'package:colored/sources/app/styling/colors/colored_color_scheme.dart';
import 'package:colored/sources/app/styling/colors/dark_color_scheme.dart';
import 'package:colored/sources/app/styling/fonts/default_font_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:flutter/material.dart';

typedef ThemeDataBuilder = Widget Function(
  ThemeData lightTheme,
  ThemeData darkTheme,
);

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    @required this.builder,
    Key key,
    this.lightColorScheme = const DarkColorScheme(),
    this.darkColorScheme = const DarkColorScheme(),
    this.fontScheme = const DefaultFontScheme(),
  }) : super(key: key);

  final ColoredColorScheme lightColorScheme;
  final ColoredColorScheme darkColorScheme;
  final FontScheme fontScheme;
  final ThemeDataBuilder builder;

  @override
  Widget build(BuildContext context) {
    final opacityScheme = OpacityData.of(context).opacityScheme;
    final darkThemeComposer = ColoredThemeComposer(
      colors: darkColorScheme,
      opacity: opacityScheme,
      fonts: fontScheme,
    );
    final lightThemeComposer = ColoredThemeComposer(
      colors: lightColorScheme,
      opacity: opacityScheme,
      fonts: fontScheme,
    );
    return builder(
      lightThemeComposer.getThemeData(),
      darkThemeComposer.getThemeData(),
    );
  }
}
