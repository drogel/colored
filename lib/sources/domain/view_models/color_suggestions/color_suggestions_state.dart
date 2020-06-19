import 'package:colored/sources/domain/data_models/named_color.dart';

class ColorSuggestionsState {
  const ColorSuggestionsState();
}

class Loading extends ColorSuggestionsState {
  const Loading();
}

class SuggestionsFound extends ColorSuggestionsState {
  const SuggestionsFound(this.colorSuggestions);

  final List<NamedColor> colorSuggestions;
}

class Failed extends ColorSuggestionsState {
  const Failed();
}
