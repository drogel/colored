abstract class NamesService {
  Map<String, String> fetchNamesContaining(String searchString);

  Future<void> loadNames();
}
