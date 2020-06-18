abstract class SuggestionsService {
  Map<String, dynamic> fetchSuggestions();

  Future<void> loadSuggestions();

  void dispose();
}
