import 'package:collection/collection.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter/foundation.dart';
import 'package:vector_math/hash.dart';

class Palette {
  const Palette({@required this.name, @required this.namedColors})
      : assert(name != null),
        assert(namedColors != null);

  final String name;
  final List<NamedColor> namedColors;

  @override
  bool operator ==(Object other) =>
      other is Palette &&
      const ListEquality().equals(
        other.namedColors,
        namedColors,
      );

  @override
  int get hashCode => hashObjects([name, namedColors]);
}
