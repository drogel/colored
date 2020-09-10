abstract class SuggestionsService<T> {
  Future<Map<String, T>> fetchSuggestions(int estimatedCount);
}
