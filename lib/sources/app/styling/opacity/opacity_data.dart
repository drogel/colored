import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:flutter/material.dart';

class OpacityData extends InheritedWidget {
  const OpacityData({
    required this.opacityScheme,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final OpacityScheme opacityScheme;

  static OpacityData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: OpacityData);

  @override
  bool updateShouldNotify(OpacityData oldWidget) =>
      opacityScheme != oldWidget.opacityScheme;
}
