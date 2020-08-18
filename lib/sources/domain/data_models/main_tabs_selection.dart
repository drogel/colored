enum MainTabsSelection {
  converter,
  colors,
}

class MainTabsSelectionBuilder {
  static MainTabsSelection fromRawValue(int value) {
    final reversedValues = _values.map((key, value) => MapEntry(value, key));
    return reversedValues[value];
  }
}

const Map<MainTabsSelection, int> _values = {
  MainTabsSelection.converter: 0,
  MainTabsSelection.colors: 1,
};

extension MainTabsValues on MainTabsSelection {
  int get rawValue => _values[this];
}
