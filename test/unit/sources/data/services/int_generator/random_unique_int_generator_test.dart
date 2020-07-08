import 'package:colored/sources/data/services/int_generator/int_generator.dart';
import 'package:colored/sources/data/services/int_generator/random_unique_int_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  IntGenerator generator;

  setUp(() {
    generator = const RandomUniqueIntGenerator();
  });

  tearDown(() {
    generator = null;
  });

  void runIntBoundedTest(int max, {int length = 10}) {
    final ints = generator.generate(max: max, length: length);
    for (final int in ints) {
      expect(int, allOf(greaterThanOrEqualTo(0), lessThanOrEqualTo(max)));
    }
  }

  void runIntListLengthTest(int max, {int length = 10}) {
    final ints = generator.generate(max: max, length: length);
    expect(ints.length, length);
  }

  void runMaxLengthTest(int max, {int length = 10}) {
    final ints = generator.generate(max: max, length: length);
    expect(ints.length, max);
  }

  group("Given a RandomUniqueIntGenerator", () {
    group("when generate is called", () {
      test("then all the ints are bounded between 0 and max", () {
        runIntBoundedTest(1);
        runIntBoundedTest(100);
        runIntBoundedTest(10000);
        runIntBoundedTest(1, length: 1);
        runIntBoundedTest(100, length: 100);
        runIntBoundedTest(10000, length: 1000);
      });

      test("then the list of ints has the given length if max > length", () {
        runIntListLengthTest(100);
        runIntListLengthTest(10);
        runIntListLengthTest(10000);
        runIntListLengthTest(1, length: 1);
        runIntListLengthTest(100, length: 100);
        runIntListLengthTest(10000, length: 1000);
      });

      test("then the list of ints has a length of max if max <= length", () {
        runMaxLengthTest(100, length: 1000);
        runMaxLengthTest(1000, length: 10000);
        runMaxLengthTest(10, length: 10000);
        runMaxLengthTest(1);
        runMaxLengthTest(10);
      });
    });
  });
}