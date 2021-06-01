import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';
import 'colors_suggestions_search_entry_test.dart';
import 'random_colors_suggestions_entry_test.dart';

class ColorsSuggestionsEntryTester extends EntryTester<ColorsSuggestionsEntry> {
  const ColorsSuggestionsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_suggestions",
        "endpoint": "https://test.com/suggestions/colors/{hex}",
        "entries": [
          {
            "title": "random_colors_suggestions",
            "endpoint": "https://test.com/suggestions/colors/random"
          },
          {
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
          }
        ]
      };

  @override
  void assertExpectations(ColorsSuggestionsEntry entry) {
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_suggestions",
      expectedPathSegments: ["suggestions", "colors", "{hex}"],
    );
    final randomTester = RandomColorsSuggestionsEntryTester(testRunner);
    final randomEntry = entry.random;
    assertChildEntryExpectations(entryTester: randomTester, entry: randomEntry);
    final searchTester = ColorsSuggestionsSearchEntryTester(testRunner);
    final searchEntry = entry.search;
    assertChildEntryExpectations(entryTester: searchTester, entry: searchEntry);
  }
}

void main() {
  group("Given a $ColorsSuggestionsEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSuggestionsEntryTester(testRunner);
        final entry = ColorsSuggestionsEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
