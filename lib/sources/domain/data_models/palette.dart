import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/nameable.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:vector_math/hash.dart';

class Palette extends Nameable {
  const Palette({
    required String name,
    required this.hexCodes,
  }) : super(name);

  factory Palette.fromMapEntry(MapEntry<String, List<String>?> mapEntry) {
    final hexCodes = mapEntry.value!.map((c) => "#${c.toUpperCase()}").toList();
    return Palette(name: mapEntry.key, hexCodes: hexCodes);
  }

  factory Palette.fromJson(Map<String, dynamic> json) {
    final hexEntries = json[hexCodesKey];
    final hexes = hexEntries.map((entry) => entry[NamedColor.hexKey]).toList();
    final hexCodes =
        List<String>.from(hexes).map((hex) => hex.toUpperCase()).toList();
    return Palette(name: json[_Key.name.value], hexCodes: hexCodes);
  }

  factory Palette.fromNamedColor(NamedColor namedColor) =>
      Palette(name: namedColor.name, hexCodes: [namedColor.hex]);

  static String nameKey = _Key.name.value;
  static String hexCodesKey = _Key.hexCodes.value;
  static String suggestionMappingKey = "palette";

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
