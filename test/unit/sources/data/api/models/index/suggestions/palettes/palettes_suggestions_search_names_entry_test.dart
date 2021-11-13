import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/palettes_suggestions_search_names_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';

class PalettesSuggestionsSearchNamesEntryTester
    extends EntryTester<PalettesSuggestionsSearchNamesEntry> {
  const PalettesSuggestionsSearchNamesEntryTester(
    ApiIndexEntryTestRunner testRunner,
  ) : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "palettes_suggestions_search_names",
        "endpoint":
            "https://test.com/suggestions/palettes/search/names?name={name}"
      };

  @override
  void assertExpectations(PalettesSuggestionsSearchNamesEntry entry) {
    final expectedPathSegments = ["suggestions", "palettes", "search", "names"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "palettes_suggestions_search_names",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["name"],
    );
  }
}

void main() {
  group("Given a $PalettesSuggestionsSearchNamesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesSuggestionsSearchNamesEntryTester(testRunner);
        final entry =
            PalettesSuggestionsSearchNamesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = PalettesSuggestionsSearchNamesEntry(
          title: title,
          endpoint: uri,
        );
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
