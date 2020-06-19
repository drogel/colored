import 'package:flutter/foundation.dart';

abstract class RandomGenerator {
  List<int> getList({@required int max, @required int length});
}