import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:flutter/material.dart';

class PaddingData extends InheritedWidget {
  const PaddingData({
    required this.paddingScheme,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final PaddingScheme paddingScheme;

  static PaddingData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PaddingData);

  @override
  bool updateShouldNotify(PaddingData oldWidget) =>
      paddingScheme != oldWidget.paddingScheme;
}
