import 'dart:async';

import 'package:colored/sources/data/services/data_loader/color_names_loader.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoizerStub implements Memoizer<Map<String, String>> {
  const MemoizerStub();

  static const mockResult = {
    "TestKey": "TestValue"
  };

  @override
  Future<Map<String, String>> runOnce(
    FutureOr Function() computation,
  ) async =>
      mockResult;
}

void main() {
  ColorNamesLoader loader;
  Memoizer memoizer;

  setUp(() {
    memoizer = const MemoizerStub();
    loader = ColorNamesLoader(memoizer: memoizer);
  });

  tearDown(() {
    memoizer = null;
    loader = null;
  });

  group("Given a ColorNamesLoader", () {
    group("when constructed", () {
      test("then should throw if given a null memoizer", () {
        expect(
          () => ColorNamesLoader(memoizer: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when load is called", () {
      test("then returns value of the computation in the memoizer", () async {
        final actual = await loader.load();
        expect(actual, MemoizerStub.mockResult);
      });
    });
  });
}
