import 'package:flutter/cupertino.dart';

class ColorSelection {
  const ColorSelection({
    @required this.firstComponent,
    @required this.secondComponent,
    @required this.thirdComponent,
  })  : assert(firstComponent != null),
        assert(secondComponent != null),
        assert(thirdComponent != null);

  final double firstComponent;
  final double secondComponent;
  final double thirdComponent;

  @override
  bool operator ==(Object other) =>
      other is ColorSelection &&
      other.firstComponent == firstComponent &&
      other.secondComponent == secondComponent &&
      other.thirdComponent == thirdComponent;

  @override
  int get hashCode =>
      firstComponent.hashCode +
      secondComponent.hashCode +
      thirdComponent.hashCode;
}
