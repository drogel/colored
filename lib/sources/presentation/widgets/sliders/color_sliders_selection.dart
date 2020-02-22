import 'package:flutter/cupertino.dart';

class ColorSlidersSelection {
  const ColorSlidersSelection({
    @required this.firstSliderValue,
    @required this.secondSliderValue,
    @required this.thirdSliderValue,
  })  : assert(firstSliderValue != null),
        assert(secondSliderValue != null),
        assert(thirdSliderValue != null);

  final double firstSliderValue;
  final double secondSliderValue;
  final double thirdSliderValue;
}
