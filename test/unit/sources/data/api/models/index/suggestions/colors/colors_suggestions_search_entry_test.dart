import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';
import 'colors_suggestions_search_hexes_entry_test.dart';
import 'colors_suggestions_search_names_entry_test.dart';

class ColorsSuggestionsSearchEntryTester
    extends EntryTester<ColorsSuggestionsSearchEntry> {
  const ColorsSuggestionsSearchEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_suggestions_search",
        "entries": [
          {
            "title": "colors_suggestions_search_hexes",
            "endpoint":
                "https://test.com/suggestions/colors/search/hexes?hex={hex}",
            "entries": [
              {
                "title": "colors_suggestions_search_closest",
                "endpoint":
                    "https://test.com/suggestions/colors/search/hexes/closest?hex={hex}"
              }
            ]
          },
          {
            "title": "colors_suggestions_search_names",
            "endpoint":
                "https://test.com/suggestions/colors/search/names?name={name}"
          }
        ]
      };

  @override
  void assertExpectations(ColorsSuggestionsSearchEntry entry) {
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_suggestions_search",
    );
    final searchHexesTester = ColorsSuggestionsSearchHexesEntryTester(
      testRunner,
    );
    final searchHexesEntry = entry.hexes;
    assertChildEntryExpectations(
      entryTester: searchHexesTester,
      entry: searchHexesEntry,
    );
    final searchNamesTester = ColorsSuggestionsSearchNamesEntryTester(
      testRunner,
    );
    final searchNamesEntry = entry.names;
    assertChildEntryExpectations(
      entryTester: searchNamesTester,
      entry: searchNamesEntry,
    );
  }
}

void main() {
  group("Given a $ColorsSuggestionsSearchEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSuggestionsSearchEntryTester(testRunner);
        final entry = ColorsSuggestionsSearchEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
