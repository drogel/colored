import 'package:flutter/foundation.dart';

abstract class IntGenerator {
  List<int> generate({required int max, required int? length});
}