import 'package:flutter/foundation.dart';
import 'package:vector_math/hash.dart';

class NamedColor {
  const NamedColor({
    @required this.name,
    @required this.hex,
  });

  final String name;
  final String hex;

  @override
  bool operator ==(Object other) =>
      other is NamedColor && other.name == name && other.hex == hex;

  @override
  int get hashCode => hashObjects([name, hex]);
}
