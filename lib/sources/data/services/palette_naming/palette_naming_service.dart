import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';

abstract class PaletteNamingService {
  Future<PaletteNamingResponse> getNaming({required List<String> hexColors});
}
