abstract class NamesService {
  Future<Map<String, String>> fetchNamesContaining(String searchString);

  Future<void> loadNames();

  void dispose();
}
