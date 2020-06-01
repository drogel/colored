import 'package:colored/sources/app/styling/fonts/font_scheme.dart';
import 'package:colored/sources/app/styling/fonts/font_constants.dart' as fonts;

class DefaultFonts implements FontScheme {
  const DefaultFonts();

  @override
  String get primary => fonts.body;

  @override
  String get secondary => fonts.header;
}
