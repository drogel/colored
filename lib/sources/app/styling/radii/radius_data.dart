import 'package:colored/sources/app/styling/radii/radii_scheme.dart';
import 'package:flutter/material.dart';

class RadiusData extends InheritedWidget {
  const RadiusData({
    required this.radiiScheme,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final RadiiScheme radiiScheme;

  static RadiusData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: RadiusData);

  @override
  bool updateShouldNotify(RadiusData oldWidget) =>
      radiiScheme != oldWidget.radiiScheme;
}
