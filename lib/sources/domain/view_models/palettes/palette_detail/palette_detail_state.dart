import 'package:colored/sources/domain/data_models/named_color.dart';

class PaletteDetailState {
  const PaletteDetailState(this.paletteName);

  final String paletteName;
}

class Pending extends PaletteDetailState {
  const Pending(
    String paletteName,
    this.requestedHexCodes,
  ) : super(paletteName);

  factory Pending.empty() => const Pending("", []);

  final List<String> requestedHexCodes;
}

class Failed extends PaletteDetailState {
  const Failed(String paletteName) : super(paletteName);
}

class PaletteFound extends PaletteDetailState {
  const PaletteFound(this.namedColors, String paletteName) : super(paletteName);

  final List<NamedColor> namedColors;
}
