import 'package:colored/sources/domain/data_models/format.dart';

abstract class Converter {
  Map<Format, String> convert(int r, int g, int b);
}