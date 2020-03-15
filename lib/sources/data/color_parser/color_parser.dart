import 'package:colored/sources/domain/data_models/color_selection.dart';

abstract class ColorParser {
  final RegExp doubleRegExp = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
  ColorSelection parse(String string);
  bool hasMatch(String input);
}