import 'package:colored/sources/domain/data_models/palette.dart';

class PaletteSuggestionsState {
  const PaletteSuggestionsState();
}

class Loading extends PaletteSuggestionsState {
  const Loading();
}

class PaletteSuggestionsFound extends PaletteSuggestionsState {
  const PaletteSuggestionsFound(this.paletteSuggestions);

  final List<Palette> paletteSuggestions;
}

class Failed extends PaletteSuggestionsState {
  const Failed();
}
