import 'package:colored/sources/domain/data_models/named_color.dart';

class NamesListState {
  const NamesListState();
}

class Busy extends NamesListState {
  const Busy();
}

class Found extends NamesListState {
  const Found(this.namedColors);

  final List<NamedColor> namedColors;
}
