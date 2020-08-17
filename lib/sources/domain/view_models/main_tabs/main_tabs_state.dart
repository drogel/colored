import 'package:flutter/foundation.dart';

class MainTabsState {
  const MainTabsState({@required this.currentIndex})
      : assert(currentIndex != null);

  final int currentIndex;
}
