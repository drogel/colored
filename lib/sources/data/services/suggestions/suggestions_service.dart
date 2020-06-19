abstract class SuggestionsService {
  Map<String, dynamic> fetchRandomSuggestions(int desiredSuggestionsLength);

  Future<void> loadSuggestions();

  void dispose();
}
