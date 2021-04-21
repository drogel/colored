import 'package:colored/sources/app/styling/elevation/elevation_scheme.dart';
import 'package:flutter/material.dart';

class ElevationData extends InheritedWidget {
  const ElevationData({
    required this.elevationScheme,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final ElevationScheme elevationScheme;

  static ElevationData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: ElevationData);

  @override
  bool updateShouldNotify(ElevationData oldWidget) =>
      elevationScheme != oldWidget.elevationScheme;
}
