import 'dart:ui';

import 'package:colored/sources/domain/data/color_selection.dart';
import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.color,
    @required this.rgbString,
    @required this.hexString,
    @required this.selection,
  }) : assert(color != null);

  final Color color;
  final String rgbString;
  final String hexString;
  final ColorSelection selection;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.color == color &&
      other.rgbString == rgbString &&
      other.hexString == hexString &&
      other.selection == selection;

  @override
  int get hashCode => color.hashCode;
}
