import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/random_palettes_suggestions_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';

class RandomPalettesSuggestionsEntryTester
    extends EntryTester<RandomPalettesSuggestionsEntry> {
  const RandomPalettesSuggestionsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "random_palettes_suggestions",
        "endpoint": "https://test.com/suggestions/palettes/random"
      };

  @override
  void assertExpectations(RandomPalettesSuggestionsEntry entry) {
    final expectedPathSegments = ["suggestions", "palettes", "random"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "random_palettes_suggestions",
      expectedPathSegments: expectedPathSegments,
    );
  }
}

void main() {
  group("Given a $RandomPalettesSuggestionsEntryTester", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = RandomPalettesSuggestionsEntryTester(testRunner);
        final entry = RandomPalettesSuggestionsEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
