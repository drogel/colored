import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/hash.dart';

class ConverterState {
  const ConverterState({
    @required this.formatData,
  });

  final Map<Format, String> formatData;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      const MapEquality().equals(formatData, other.formatData);

  @override
  int get hashCode => hashObjects([this, formatData]);

  @override
  String toString() => """ConverterState(
      formatData: $formatData,
   )""";
}

