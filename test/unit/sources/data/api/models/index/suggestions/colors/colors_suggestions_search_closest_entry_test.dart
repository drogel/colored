import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_closest_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';

class ColorsSuggestionsSearchClosestEntryTester
    extends EntryTester<ColorsSuggestionsSearchClosestEntry> {
  const ColorsSuggestionsSearchClosestEntryTester(
      ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_suggestions_search_closest",
        "endpoint":
            "https://test.com/suggestions/colors/search/hexes/closest?hex={hex}"
      };

  @override
  void assertExpectations(ColorsSuggestionsSearchClosestEntry entry) {
    final expectedPathSegments = [
      "suggestions",
      "colors",
      "search",
      "hexes",
      "closest",
    ];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_suggestions_search_closest",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["hex"],
    );
  }
}

void main() {
  group("Given a $ColorsSuggestionsSearchClosestEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSuggestionsSearchClosestEntryTester(testRunner);
        final entry = ColorsSuggestionsSearchClosestEntry.fromJson(
          tester.testMap,
        );
        tester.assertExpectations(entry);
      });
    });
  });
}
