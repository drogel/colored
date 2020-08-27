import 'package:colored/sources/domain/data_models/palette.dart';

class PaletteSuggestionsState {
  const PaletteSuggestionsState();
}

class Loading extends PaletteSuggestionsState {
  const Loading();
}

class PaletteSuggestionsFound extends PaletteSuggestionsState {
  const PaletteSuggestionsFound(this.palettes);

  final List<Palette> palettes;
}

class Failed extends PaletteSuggestionsState {
  const Failed();
}
