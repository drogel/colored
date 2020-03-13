import 'dart:ui';

import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.color,
    @required this.converterStep,
    @required this.rgbString,
    @required this.hexString,
    @required this.selection,
  }) : assert(color != null);

  final Color color;
  final double converterStep;
  final String rgbString;
  final String hexString;
  final ColorSelection selection;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.color == color &&
      other.converterStep == converterStep &&
      other.rgbString == rgbString &&
      other.hexString == hexString &&
      other.selection == selection;

  @override
  int get hashCode => color.hashCode;

  @override
  String toString() => """ConverterState(
      color: ${color.toString()},
      rgbString: $rgbString,
      hexString: $hexString,
      selection: $selection,
   )""";
}

class Shrinking extends ConverterState {
  const Shrinking({
    @required Color color,
    @required double converterStep,
    @required String rgbString,
    @required String hexString,
    @required ColorSelection selection,
  }) : super(
          color: color,
          converterStep: converterStep,
          rgbString: rgbString,
          hexString: hexString,
          selection: selection,
        );

  factory Shrinking.fromState(ConverterState state) => Shrinking(
        color: state.color,
        converterStep: state.converterStep,
        rgbString: state.rgbString,
        hexString: state.hexString,
        selection: state.selection,
      );
}
