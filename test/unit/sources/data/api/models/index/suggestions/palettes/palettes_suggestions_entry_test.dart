import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/palettes_suggestions_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';
import 'palettes_suggestions_search_names_entry_test.dart';
import 'random_palettes_suggestions_entry_test.dart';

class PalettesSuggestionsEntryTester
    extends EntryTester<PalettesSuggestionsEntry> {
  const PalettesSuggestionsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
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
      };

  @override
  void assertExpectations(PalettesSuggestionsEntry entry) {
    testRunner.assertExpectations(
      entry,
      expectedTitle: "palettes_suggestions",
      expectedPathSegments: ["suggestions", "palettes", "{id}"],
    );
    final randomTester = RandomPalettesSuggestionsEntryTester(testRunner);
    final randomEntry = entry.random;
    assertChildEntryExpectations(entryTester: randomTester, entry: randomEntry);
    final namesTester = PalettesSuggestionsSearchNamesEntryTester(testRunner);
    final namesEntry = entry.names;
    assertChildEntryExpectations(entryTester: namesTester, entry: namesEntry);
  }
}

void main() {
  group("Given a $PalettesSuggestionsEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesSuggestionsEntryTester(testRunner);
        final entry = PalettesSuggestionsEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
