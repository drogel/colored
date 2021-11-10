import 'package:collection/collection.dart';
import 'package:vector_math/hash.dart';

class Palette {
  const Palette({required this.name, required this.hexCodes});

  factory Palette.fromMapEntry(MapEntry<String, List<String>?> mapEntry) {
    final hexCodes = mapEntry.value!.map((c) => "#${c.toUpperCase()}").toList();
    return Palette(name: mapEntry.key, hexCodes: hexCodes);
  }

  factory Palette.fromJson(Map<String, dynamic> json) {
    final hexCodes = List<String>.from(json[_Key.hexCodes.value]);
    final hexes = hexCodes.map((hex) => hex.toUpperCase()).toList();
    return Palette(name: json[_Key.name.value], hexCodes: hexes);
  }

  static String nameKey = _Key.name.value;
  static String hexCodesKey = _Key.hexCodes.value;

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

enum _Key {
  name,
  hexCodes,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.name:
        return "name";
      case _Key.hexCodes:
        return "hexes";
    }
  }
}
