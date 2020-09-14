abstract class NamesService<T> {
  Future<Map<String, T>> fetchContainingSearch(String searchString);
}
