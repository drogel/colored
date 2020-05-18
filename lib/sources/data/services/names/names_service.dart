abstract class NamesService {
  List<String> fetchNamesContaining(String searchString);

  Future<void> loadNames();
}
