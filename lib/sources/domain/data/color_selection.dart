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
}
