import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/hash.dart';

class ConverterState {
  const ConverterState({
    @required this.selection,
    @required this.formatData,
  }) : assert(selection != null);

  final ColorSelection selection;
  final Map<Format, String> formatData;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      other.selection == selection &&
      const MapEquality().equals(formatData, other.formatData);

  @override
  int get hashCode => hashObjects([selection, formatData]);

  @override
  String toString() => """ConverterState(
      selection: $selection,
      formatData: $formatData,
   )""";
}

class Shrinking extends ConverterState {
  Shrinking(ConverterState state)
      : super(
          selection: state.selection,
          formatData: state.formatData,
        );
}

class SelectionEnded extends ConverterState {
  SelectionEnded(ConverterState state)
      : super(
          selection: state.selection,
          formatData: state.formatData,
        );
}
