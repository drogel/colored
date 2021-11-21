import 'package:flutter/animation.dart';

extension Extended on Curve {
  double extendedTransform(double t) => t.floor() + transform(t % 1);
}
