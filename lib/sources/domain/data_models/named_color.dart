import 'package:flutter/foundation.dart';
import 'package:vector_math/hash.dart';

class NamedColor {
  const NamedColor({
    @required this.name,
    @required this.hex,
  })  : assert(name != null),
        assert(hex != null);

  factory NamedColor.fromMapEntry(MapEntry<String, dynamic> entry) =>
      NamedColor(name: entry.value, hex: "#${entry.key.toUpperCase()}");

  final String name;
  final String hex;

  @override
  bool operator ==(Object other) =>
      other is NamedColor && other.name == name && other.hex == hex;

  @override
  int get hashCode => hashObjects([name, hex]);

  @override
  String toString() => "NamedColor(name: $name, hex: $hex)";
}
