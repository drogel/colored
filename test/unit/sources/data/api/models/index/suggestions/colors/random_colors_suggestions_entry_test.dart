import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/random_colors_suggestions_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';

class RandomColorsSuggestionsEntryTester
    extends EntryTester<RandomColorsSuggestionsEntry> {
  const RandomColorsSuggestionsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, String> get testMap => {
        "title": "random_colors_suggestions",
        "endpoint": "https://test.com/suggestions/colors/random"
      };

  @override
  void assertExpectations(RandomColorsSuggestionsEntry entry) {
    final expectedPathSegments = ["suggestions", "colors", "random"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "random_colors_suggestions",
      expectedPathSegments: expectedPathSegments,
    );
  }
}

void main() {
  group("Given a $RandomColorsSuggestionsEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = RandomColorsSuggestionsEntryTester(testRunner);
        final entry = RandomColorsSuggestionsEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
