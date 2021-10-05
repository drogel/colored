import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/suggestions_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import '../colors/colors_entry_test.dart';
import '../palettes/palettes_entry_test.dart';

class SuggestionsEntryTester extends EntryTester<SuggestionsEntry> {
  const SuggestionsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "suggestions",
        "entries": [
          {
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
          },
          {
            "title": "palettes_suggestions",
            "endpoint": "https://test.com/suggestions/palettes/{id}",
            "entries": [
              {
                "title": "random_palettes_suggestions",
                "endpoint": "https://test.com/suggestions/palettes/random"
              },
              {
                "title": "palettes_suggestions_search_names",
                "endpoint":
                    "https://test.com/suggestions/palettes/search/names?name={name}"
              }
            ]
          }
        ]
      };

  @override
  void assertExpectations(SuggestionsEntry entry) {
    testRunner.assertExpectations(entry, expectedTitle: "suggestions");
    final colorsTester = ColorsEntryTester(testRunner);
    final colorsEntry = entry.colors;
    assertChildEntryExpectations(
      entryTester: colorsTester,
      entry: colorsEntry,
    );
    final palettesTester = PalettesEntryTester(testRunner);
    final palettesEntry = entry.palettes;
    assertChildEntryExpectations(
      entryTester: palettesTester,
      entry: palettesEntry,
    );
  }
}

void main() {
  group("Given a $SuggestionsEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesEntryTester(testRunner);
        final entry = PalettesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
