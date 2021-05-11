import 'dart:ui';

import 'package:colored/sources/common/factors.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/hash.dart';

class ColorSelection {
  factory ColorSelection({
    required double r,
    required double g,
    required double b,
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

  factory ColorSelection.fromHSV({
    required double h,
    required double s,
    required double v,
  }) {
    final clampedH = h.clamp(0, degreesInTurn).toDouble();
    final clampedS = s.clamp(selectionMin, selectionMax).toDouble();
    final clampedV = v.clamp(selectionMin, selectionMax).toDouble();
    final hsvColor = HSVColor.fromAHSV(1, clampedH, clampedS, clampedV);
    return ColorSelection.fromColor(hsvColor.toColor());
  }

  factory ColorSelection.fromHSL({
    required double h,
    required double s,
    required double l,
  }) {
    final clampedH = h.clamp(0, degreesInTurn).toDouble();
    final clampedS = s.clamp(selectionMin, selectionMax).toDouble();
    final clampedL = l.clamp(selectionMin, selectionMax).toDouble();
    final hsvColor = HSLColor.fromAHSL(1, clampedH, clampedS, clampedL);
    return ColorSelection.fromColor(hsvColor.toColor());
  }

  const ColorSelection._({
    required this.r,
    required this.g,
    required this.b,
  });

  final double r;
  final double g;
  final double b;

  Color toColor() {
    final red = (r * decimal8Bit).round();
    final green = (g * decimal8Bit).round();
    final blue = (b * decimal8Bit).round();
    return Color.fromRGBO(red, green, blue, 1);
  }

  @override
  String toString() => "$runtimeType(r: $r, g: $g, b: $b)";

  @override
  bool operator ==(Object other) =>
      other is ColorSelection && other.r == r && other.g == g && other.b == b;

  @override
  int get hashCode => hashObjects([r, g, b]);
}
