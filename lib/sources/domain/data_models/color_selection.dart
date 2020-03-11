import 'package:flutter/cupertino.dart';

class ColorSelection {
  const ColorSelection({
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
  int get hashCode =>
      first.hashCode +
      second.hashCode +
      third.hashCode;
}
