abstract class DataLoader<T> {
  Future<Map<String, T>> load();
}
