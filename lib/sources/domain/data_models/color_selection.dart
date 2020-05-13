import 'package:colored/sources/common/factors.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/hash.dart';

class ColorSelection {
  factory ColorSelection({
    @required double first,
    @required double second,
    @required double third,
  }) {
    final clampedFirst = first.clamp(selectionMin, selectionMax).toDouble();
    final clampedSecond = second.clamp(selectionMin, selectionMax).toDouble();
    final clampedThird = third.clamp(selectionMin, selectionMax).toDouble();
    return ColorSelection._(
      first: clampedFirst,
      second: clampedSecond,
      third: clampedThird,
    );
  }

  const ColorSelection._({
    @required this.first,
    @required this.second,
    @required this.third,
  })  : assert(first != null),
        assert(second != null),
        assert(third != null);

  final double first;
  final double second;
  final double third;

  @override
  bool operator ==(Object other) =>
      other is ColorSelection &&
      other.first == first &&
      other.second == second &&
      other.third == third;

  @override
  int get hashCode => hashObjects([first, second, third]);
}
