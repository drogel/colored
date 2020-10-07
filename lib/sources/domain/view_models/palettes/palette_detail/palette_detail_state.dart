import 'package:colored/sources/domain/data_models/named_color.dart';

class PaletteDetailState {
  const PaletteDetailState();
}

class Pending extends PaletteDetailState {
  const Pending();
}

class Failed extends PaletteDetailState {
  const Failed();
}

class PaletteFound extends PaletteDetailState {
  const PaletteFound(this.namedColors) : assert(namedColors != null);

  final List<NamedColor> namedColors;
}
