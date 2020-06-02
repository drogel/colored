import 'package:flutter/material.dart';

abstract class CurveScheme {
  Cubic get main;

  Cubic get exiting;

  Cubic get incoming;
}
