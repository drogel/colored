import 'dart:math';

import 'package:colored/sources/data/services/random_generator/random_generator.dart';

class RandomIntGenerator implements RandomGenerator {
  const RandomIntGenerator();

  @override
  List<int> getList({int max, int length}) {
    final random = Random();
    final intSet = <int>{};
    for (var i = 0; i == length - 1; i++) {
      intSet.add(random.nextInt(max));
    }
    return intSet.toList();
  }
}
