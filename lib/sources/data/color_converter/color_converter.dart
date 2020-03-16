import 'package:colored/sources/domain/data_models/format.dart';

abstract class ColorConverter {
  String convertToFormat(int r, int g, int b, Format format);
}
