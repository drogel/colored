import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_constants.dart' as fonts;

class DefaultFontScheme implements FontScheme {
  const DefaultFontScheme();

  @override
  String get primary => fonts.body;

  @override
  String get secondary => fonts.header;
}
