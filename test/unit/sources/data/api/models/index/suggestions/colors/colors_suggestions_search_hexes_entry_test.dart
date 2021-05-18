import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_hexes_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';
import 'colors_suggestions_search_closest_entry_test.dart';

class ColorsSuggestionsSearchHexesEntryTester
    extends EntryTester<ColorsSuggestionsSearchHexesEntry> {
  const ColorsSuggestionsSearchHexesEntryTester(
      ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
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
      };

  @override
  void assertExpectations(ColorsSuggestionsSearchHexesEntry entry) {
    final expectedPathSegments = ["suggestions", "colors", "search", "hexes"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_suggestions_search_hexes",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["hex"],
    );
    final searchClosestTester = ColorsSuggestionsSearchClosestEntryTester(
      testRunner,
    );
    final searchClosestEntry = entry.closest;
    assertChildEntryExpectations(
      entryTester: searchClosestTester,
      entry: searchClosestEntry,
    );
  }
}

void main() {
  group("Given a $ColorsSuggestionsSearchHexesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSuggestionsSearchHexesEntryTester(testRunner);
        final entry = ColorsSuggestionsSearchHexesEntry.fromJson(
          tester.testMap,
        );
        tester.assertExpectations(entry);
      });
    });
  });
}
