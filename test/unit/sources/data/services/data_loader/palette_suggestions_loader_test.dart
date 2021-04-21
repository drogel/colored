import 'package:colored/sources/data/services/data_loader/palette_suggestions_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter_test/flutter_test.dart';

class StringBundleStub implements StringBundle {
  @override
  Future<String> load(String key) async => '{"test": ["000000", "ffffff"]}';
}

void main() {
  PaletteSuggestionsLoader? loader;

  setUp(() {
    loader = PaletteSuggestionsLoader(
        stringBundle: StringBundleStub(),
        paletteSuggestionsDataPath: "testDataPath");
  });

  tearDown(() {
    loader = null;
  });

  group("Given a stubbed PaletteSuggestionsLoader", () {
    group("when constructed", () {
      test("an AssertionError is thrown if stringBundle is null", () {
        expect(
          () => PaletteSuggestionsLoader(
            stringBundle: null,
            paletteSuggestionsDataPath: "test",
          ),
          throwsAssertionError,
        );
      });

      test("an AssertionError throws on null paletteSuggestionsDataPath", () {
        expect(
          () => PaletteSuggestionsLoader(
            stringBundle: StringBundleStub(),
            paletteSuggestionsDataPath: null,
          ),
          throwsAssertionError,
        );
      });
    });

    group("when load is called", () {
      test("then a Map<String, List<String>> is decoded from bundle", () async {
        final expected = <String, List<String>>{
          "test": ["000000", "ffffff"]
        };
        final actual = await loader!.load();

        expect(expected, actual);
      });
    });
  });
}
