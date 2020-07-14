import 'dart:async';

import 'package:colored/sources/data/services/data_loader/palettes_loader.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoizerStub implements Memoizer<Map<String, List<String>>> {
  const MemoizerStub();

  static const mockResult = {
    "TestKey": ["Test1", "Test2"]
  };

  @override
  Future<Map<String, List<String>>> runOnce(
    FutureOr Function() computation,
  ) async =>
      mockResult;
}

void main() {
  PalettesLoader loader;
  Memoizer memoizer;

  setUp(() {
    memoizer = const MemoizerStub();
    loader = PalettesLoader(memoizer: memoizer);
  });

  tearDown(() {
    memoizer = null;
    loader = null;
  });

  group("Given a PaletteLoader", () {
    group("when constructed", () {
      test("then should throw if given a null memoizer", () {
        expect(
          () => PalettesLoader(memoizer: null),
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
