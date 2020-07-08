import 'package:flutter/material.dart';

abstract class ColorPurifier {
  Color purify(Color color);

  double getHue(Color color);

  Color getPureColorFromHue(double hue);
}