import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({@required this.color}) : assert(color != null);

  final Color color;

  @override
  bool operator ==(Object other) =>
      other is ConverterState && other.color == color;

  @override
  int get hashCode => color.hashCode;
}
