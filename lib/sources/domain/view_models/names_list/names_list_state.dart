import 'package:colored/sources/domain/data_models/named_color.dart';

class NamesListState {
  const NamesListState();
}

class Pending extends NamesListState {
  const Pending();
}

class Found extends NamesListState {
  const Found(this.namedColors);

  final List<NamedColor> namedColors;
}

class NoneFound extends NamesListState {
  const NoneFound();
}
