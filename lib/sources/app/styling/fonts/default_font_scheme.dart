import 'package:colored/sources/app/styling/fonts/font_constants.dart' as fonts;
import 'package:colored/sources/app/styling/fonts/font_scheme.dart';

class DefaultFontScheme implements FontScheme {
  const DefaultFontScheme();

  @override
  String get primary => fonts.body;

  @override
  String get secondary => fonts.header;
}
