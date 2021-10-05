import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/api_index_entry_test_runner.dart';
import 'colors/colors_entry_test.dart';
import 'palettes/palettes_entry_test.dart';
import 'suggestions/suggestions_entry_test.dart';

void main() {
  const testIndex = [
    {
      "title": "colors",
      "endpoint": "https://test.com/colors/{hex}",
      "entries": [
        {
          "title": "colors_search",
          "entries": [
            {
              "title": "colors_search_hexes",
              "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
              "entries": [
                {
                  "title": "colors_search_closest",
                  "endpoint":
                      "https://test.com/colors/search/hexes/closest?hex={hex}"
                }
              ]
            },
            {
              "title": "colors_search_names",
              "endpoint": "https://test.com/colors/search/names?name={name}"
            }
          ]
        }
      ]
    },
    {
      "title": "palettes",
      "endpoint": "https://test.com/palettes/{id}",
      "entries": [
        {
          "title": "palettes_search",
          "entries": [
            {
              "title": "palettes_search_names",
              "endpoint": "https://test.com/palettes/search/names?name={name}"
            }
          ]
        }
      ]
    },
    {
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
    }
  ];

  group("Given an $ApiIndex", () {
    group("when constraucted from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const colorsTester = ColorsEntryTester(testRunner);
        const palettesTester = PalettesEntryTester(testRunner);
        const suggestionsTester = SuggestionsEntryTester(testRunner);
        final apiIndex = ApiIndex.fromJsonEntries(testIndex);
        final colors = apiIndex.colors;
        final palettes = apiIndex.palettes;
        final suggestions = apiIndex.suggestions;

        if (colors != null && palettes != null && suggestions != null) {
          colorsTester.assertExpectations(colors);
          palettesTester.assertExpectations(palettes);
          suggestionsTester.assertExpectations(suggestions);
        } else {
          fail("$ApiIndex parsing failed, expected all entries != null.");
        }
      });
    });
  });
}
