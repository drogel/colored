import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/format.dart';

class ConverterState {
  const ConverterState({
    required this.formatData,
  });

  final Map<Format, String> formatData;

  @override
  bool operator ==(Object other) =>
      other is ConverterState &&
      const MapEquality().equals(formatData, other.formatData);

  @override
  int get hashCode => formatData.hashCode;

  @override
  String toString() => "$runtimeType(formatData: $formatData)";
}
