import 'package:vector_math/hash.dart';

class NamedColor {
  const NamedColor({
    required this.name,
    required this.hex,
  });

  factory NamedColor.fromMapEntry(MapEntry<String, dynamic> entry) =>
      NamedColor(name: entry.value, hex: "#${entry.key.toUpperCase()}");

  factory NamedColor.fromJson(Map<String, dynamic> json) => NamedColor(
        name: json[_Key.name.value],
        hex: json[_Key.hex.value].toUpperCase(),
      );

  static String nameKey = _Key.name.value;
  static String hexKey = _Key.hex.value;

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

enum _Key {
  name,
  hex,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.name:
        return "name";
      case _Key.hex:
        return "hex";
    }
  }
}
