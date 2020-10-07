import 'package:colored/sources/domain/data_models/named_color.dart';

class PaletteDetailState {
  const PaletteDetailState(this.paletteName) : assert(paletteName != null);

  final String paletteName;
}

class Pending extends PaletteDetailState {
  const Pending(String paletteName) : super(paletteName);

  factory Pending.empty() => const Pending("");
}

class Failed extends PaletteDetailState {
  const Failed(String paletteName) : super(paletteName);
}

class PaletteFound extends PaletteDetailState {
  const PaletteFound(this.namedColors, String paletteName)
      : assert(namedColors != null),
        super(paletteName);

  final List<NamedColor> namedColors;
}
