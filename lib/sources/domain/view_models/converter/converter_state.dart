import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.color,
    @required this.rgbString,
    @required this.hexString,
  }) : assert(color != null);

  final Color color;
  final String rgbString;
  final String hexString;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.color == color &&
      other.rgbString == rgbString &&
      other.hexString == hexString;

  @override
  int get hashCode => color.hashCode;
}
