import 'dart:math';

import 'package:colored/sources/data/services/int_generator/int_generator.dart';

class RandomUniqueIntGenerator implements IntGenerator {
  const RandomUniqueIntGenerator();

  @override
  List<int> generate({int max, int length}) {
    final random = Random();
    final intSet = <int>{};
    for (var i = 0; i <= length; i++) {
      intSet.add(random.nextInt(max));
    }
    return intSet.toList();
  }
}
