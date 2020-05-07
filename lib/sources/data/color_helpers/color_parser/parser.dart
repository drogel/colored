import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';

abstract class Parser {
  ColorSelection parseToFormat(String string, Format format);

  bool isStringOfFormat(String string, Format format);
}
