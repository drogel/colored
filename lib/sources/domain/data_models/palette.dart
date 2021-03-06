import 'package:collection/collection.dart';
import 'package:vector_math/hash.dart';

class Palette {
  const Palette({required this.name, required this.hexCodes});

  factory Palette.fromMapEntry(MapEntry<String, List<String>?> mapEntry) {
    final hexCodes = mapEntry.value!.map((c) => "#${c.toUpperCase()}").toList();
    return Palette(name: mapEntry.key, hexCodes: hexCodes);
  }

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
