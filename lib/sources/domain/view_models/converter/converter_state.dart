import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.color,
    @required this.rgbComponents,
  }) : assert(color != null);

  final Color color;
  final String rgbComponents;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.color == color &&
      other.rgbComponents == rgbComponents;

  @override
  int get hashCode => color.hashCode;
}
