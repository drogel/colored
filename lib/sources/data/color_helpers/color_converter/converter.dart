import 'package:colored/sources/domain/data_models/format.dart';

abstract class Converter {
  String convertToFormat(int r, int g, int b, Format format);
}
