import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.color,
    @required this.converterStep,
    @required this.selection,
    @required this.formatData,
  }) : assert(color != null);

  final Color color;
  final double converterStep;
  final ColorSelection selection;
  final Map<Format, String> formatData;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.color == color &&
      other.converterStep == converterStep &&
      other.selection == selection &&
      const MapEquality().equals(formatData, other.formatData);

  @override
  int get hashCode => color.hashCode;

  @override
  String toString() => """ConverterState(
      color: ${color.toString()},
      selection: $selection,
      formatData: $formatData,
   )""";
}

class Shrinking extends ConverterState {
  Shrinking(ConverterState state)
      : super(
          color: state.color,
          converterStep: state.converterStep,
          selection: state.selection,
          formatData: state.formatData,
        );
}

class SelectionEnded extends ConverterState {
  SelectionEnded(ConverterState state)
      : super(
          color: state.color,
          converterStep: state.converterStep,
          selection: state.selection,
          formatData: state.formatData,
        );
}

class SelectionStarted extends ConverterState {
  SelectionStarted(ConverterState state)
      : super(
          color: state.color,
          converterStep: state.converterStep,
          selection: state.selection,
          formatData: state.formatData,
        );
}
