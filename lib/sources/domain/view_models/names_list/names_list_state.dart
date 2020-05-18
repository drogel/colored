class NamesListState {
  const NamesListState();
}

class Busy extends NamesListState {
  const Busy();
}

class Found extends NamesListState {
  const Found(this.colorsMap);

  final Map<String, String> colorsMap;
}
