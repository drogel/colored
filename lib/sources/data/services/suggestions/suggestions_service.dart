abstract class SuggestionsService {
  Future<Map<String, dynamic>> fetchSuggestions(int estimatedCount);
}
