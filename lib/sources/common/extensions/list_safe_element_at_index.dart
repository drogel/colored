extension ListSafeElementAtIndex<T> on List<T> {
  T? safeElementAt(int index) =>
      asMap().containsKey(index) ? elementAt(index) : null;
}
