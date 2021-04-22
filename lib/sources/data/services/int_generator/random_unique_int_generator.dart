import 'dart:math';

import 'package:colored/sources/data/services/int_generator/int_generator.dart';

class RandomUniqueIntGenerator implements IntGenerator {
  const RandomUniqueIntGenerator();

  @override
  List<int> generate({required int max, required int length}) => max <= length
      ? _getAllPossibleInts(max)
      : _getRandomUniqueInts(max, length);

  List<int> _getAllPossibleInts(int max) => List.generate(max, (i) => i);

  List<int> _getRandomUniqueInts(int max, int length) {
    final random = Random();
    final intSet = <int>{};
    while (intSet.length < length) {
      intSet.add(random.nextInt(max));
    }
    return intSet.toList();
  }
}
