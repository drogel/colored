import 'dart:async';

import 'package:colored/sources/data/services/data_loader/color_names_loader.dart';
import 'package:colored/sources/data/services/memoizer/default_memoizer.dart';
import 'package:colored/sources/data/services/memoizer/memoizer.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoizerStub implements Memoizer<Map<String, String>> {
  const MemoizerStub();

  static const mockResult = {"TestKey": "TestValue"};

  @override
  Future<Map<String, String>> runOnce(
    FutureOr Function() computation,
  ) async =>
      mockResult;
}

class StringBundleStub implements StringBundle {
  const StringBundleStub();

  @override
  Future<String> load(String key) async => '{"000000":"test"}';
}

void main() {
  late ColorNamesLoader loader;
  late Memoizer memoizer;
  late StringBundle stringBundle;

  setUp(() {
    memoizer = const MemoizerStub();
    stringBundle = const StringBundleStub();
    loader = ColorNamesLoader(
      memoizer: memoizer as Memoizer<Map<String, String>>,
      stringBundle: stringBundle,
      colorsDataPath: "testPath",
    );
  });

  group("Given a ColorNamesLoader", () {
    group("when constructed", () {
      group("when load is called", () {
        test("then returns value of the computation in the memoizer", () async {
          final actual = await loader.load();
          expect(actual, MemoizerStub.mockResult);
        });
      });
    });

    group("Given a ColorsNamesLoader with a DefaultMemoizer", () {
      setUp(() {
        memoizer = DefaultMemoizer<Map<String, String>>();
        stringBundle = const StringBundleStub();
        loader = ColorNamesLoader(
          memoizer: memoizer as Memoizer<Map<String, String>>,
          stringBundle: stringBundle,
          colorsDataPath: "testPath",
        );
      });

      group("when load is called", () {
        test("then returns the decoded json string from the bundle", () async {
          final actual = await loader.load();
          expect(actual, {"000000": "test"});
        });
      });
    });
  });
}
