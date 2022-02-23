import 'package:colored/sources/domain/data_models/nameable.dart';

class NamedColor extends Nameable {
  const NamedColor({
    required String name,
    required this.hex,
  }) : super(name);

  factory NamedColor.fromMapEntry(MapEntry<String, dynamic> entry) =>
      NamedColor(name: entry.value, hex: "#${entry.key.toUpperCase()}");

  factory NamedColor.fromJson(Map<String, dynamic> json) => NamedColor(
        name: json[_Key.name.value],
        hex: json[_Key.hex.value].toUpperCase(),
      );

  static String hexKey = _Key.hex.value;
  static String mocksMappingKey = "colors";
  static String suggestionMappingKey = "color";

  final String hex;

  @override
  bool operator ==(Object other) =>
      other is NamedColor && other.name == name && other.hex == hex;

  @override
  int get hashCode => Object.hashAll([name, hex]);

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
