import 'dart:async';

import 'package:colored/sources/data/services/data_loader/palettes_loader.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMemoizer extends Mock implements Memoizer<Map<String, List<String>>> {
}

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

class StringBundleStub implements StringBundle {
  const StringBundleStub();

  @override
  Future<String> load(String key) async => '{"test": ["000000", "ffffff"]}';
}

void main() {
  late PalettesLoader loader;
  late Memoizer memoizer;
  late StringBundle stringBundle;

  setUp(() {
    memoizer = const MemoizerStub();
    stringBundle = const StringBundleStub();
    loader = PalettesLoader(
      memoizer: memoizer as Memoizer<Map<String, List<String>>>,
      stringBundle: stringBundle,
      palettesDataPath: "testPath",
    );
  });

  group("Given a PalettesLoader", () {
    group("when load is called", () {
      test("then returns value of the computation in the memoizer", () async {
        final actual = await loader.load();
        expect(actual, MemoizerStub.mockResult);
      });
    });
  });

  group("Given a PalettesLoader with a mock memoizer", () {
    setUp(() {
      memoizer = MockMemoizer();
      stringBundle = const StringBundleStub();
      loader = PalettesLoader(
        memoizer: memoizer as Memoizer<Map<String, List<String>>>,
        stringBundle: stringBundle,
        palettesDataPath: "testPath",
      );
    });
  });

  group("Given a PalettesLoader with a DefaultMemoizer", () {
    setUp(() {
      memoizer = DefaultMemoizer<Map<String, List<String>>>();
      stringBundle = const StringBundleStub();
      loader = PalettesLoader(
        memoizer: memoizer as Memoizer<Map<String, List<String>>>,
        stringBundle: stringBundle,
        palettesDataPath: "testPath",
      );
    });

    group("when load is called", () {
      test("then returns the decoded json string from the bundle", () async {
        final actual = await loader.load();
        expect(actual, {
          "test": ["000000", "ffffff"]
        });
      });
    });
  });
}
