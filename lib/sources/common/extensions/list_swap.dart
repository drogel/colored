extension ListSwap on List {
  void swap(int x, int y) {
    var tmp = this[x];
    this[x] = this[y];
    this[y] = tmp;
  }
}
