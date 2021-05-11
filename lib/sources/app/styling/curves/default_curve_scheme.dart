import 'package:colored/sources/app/styling/curves/curve_constants.dart' as curves;
import 'package:colored/sources/app/styling/curves/curve_scheme.dart';
import 'package:flutter/material.dart';

class DefaultCurveScheme implements CurveScheme {
  const DefaultCurveScheme();

  @override
  Cubic get exiting => curves.exiting;

  @override
  Cubic get incoming => curves.incoming;

  @override
  Cubic get main => curves.base;
}