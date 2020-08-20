import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter/foundation.dart';
import 'package:vector_math/hash.dart';

class Palette {
  const Palette({@required this.name, @required this.hexCodes})
      : assert(name != null),
        assert(hexCodes != null);

  factory Palette.fromMapEntry(MapEntry<String, List<String>> mapEntry) =>
      Palette(name: mapEntry.key, hexCodes: mapEntry.value);

  final String name;
  final List<String> hexCodes;

  @override
  bool operator ==(Object other) =>
      other is Palette &&
      const ListEquality().equals(
        other.hexCodes,
        hexCodes,
      );

  @override
  int get hashCode => hashObjects([name, hexCodes]);

  @override
  String toString() => "Palette(name: $name, hexCodes: $hexCodes)";
}
