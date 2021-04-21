import 'package:colored/sources/data/services/data_loader/color_suggestions_loader.dart';
import 'package:colored/sources/data/services/string_bundle/string_bundle.dart';
import 'package:flutter_test/flutter_test.dart';

class StringBundleStub implements StringBundle {
  @override
  Future<String> load(String key) async => '{"test":"000000"}';
}

void main() {
  ColorSuggestionsLoader? loader;

  setUp(() {
    loader = ColorSuggestionsLoader(
      stringBundle: StringBundleStub(),
      colorSuggestionsDataPath: "testPath",
    );
  });

  tearDown(() {
    loader = null;
  });

  group("Given a stubbed ColorSuggestionsLoader", () {
    group("when constructed", () {
      test("an assertion error is thrown if the stringBundle is null", () {
        expect(
          () => ColorSuggestionsLoader(
            stringBundle: null,
            colorSuggestionsDataPath: "testPath",
          ),
          throwsAssertionError,
        );
      });

      test("an assertion error is thrown if the stringBundle is null", () {
        expect(
          () => ColorSuggestionsLoader(
            stringBundle: StringBundleStub(),
            colorSuggestionsDataPath: null,
          ),
          throwsAssertionError,
        );
      });
    });

    group("when load is called", () {
      test("then a Map<String, String> is decoded from StringBundle", () async {
        final expected = <String, String>{"test": "000000"};
        final actual = await loader!.load();

        expect(expected, actual);
      });
    });
  });
}
