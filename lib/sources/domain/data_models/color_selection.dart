import 'dart:ui';

import 'package:colored/sources/common/factors.dart';
import 'package:flutter/foundation.dart';
import 'package:vector_math/hash.dart';

class ColorSelection {
  factory ColorSelection({
    @required double r,
    @required double g,
    @required double b,
  }) {
    final clampedFirst = r.clamp(selectionMin, selectionMax).toDouble();
    final clampedSecond = g.clamp(selectionMin, selectionMax).toDouble();
    final clampedThird = b.clamp(selectionMin, selectionMax).toDouble();
    return ColorSelection._(
      r: clampedFirst,
      g: clampedSecond,
      b: clampedThird,
    );
  }

  factory ColorSelection.fromColor(Color color) => ColorSelection(
        r: color.red / decimal8Bit,
        g: color.green / decimal8Bit,
        b: color.blue / decimal8Bit,
      );

  const ColorSelection._({
    @required this.r,
    @required this.g,
    @required this.b,
  })  : assert(r != null),
        assert(g != null),
        assert(b != null);

  final double r;
  final double g;
  final double b;

  @override
  bool operator ==(Object other) =>
      other is ColorSelection && other.r == r && other.g == g && other.b == b;

  @override
  int get hashCode => hashObjects([r, g, b]);
}
