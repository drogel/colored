import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_names_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../../test_helpers/entry_tester.dart';

class ColorsSuggestionsSearchNamesEntryTester
    extends EntryTester<ColorsSuggestionsSearchNamesEntry> {
  const ColorsSuggestionsSearchNamesEntryTester(
    ApiIndexEntryTestRunner testRunner,
  ) : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_suggestions_search_names",
        "endpoint":
            "https://test.com/suggestions/colors/search/names?name={name}"
      };

  @override
  void assertExpectations(ColorsSuggestionsSearchNamesEntry entry) {
    final expectedPathSegments = ["suggestions", "colors", "search", "names"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_suggestions_search_names",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["name"],
    );
  }
}

void main() {
  group("Given a $ColorsSuggestionsSearchNamesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSuggestionsSearchNamesEntryTester(testRunner);
        final entry =
            ColorsSuggestionsSearchNamesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = ColorsSuggestionsSearchNamesEntry(
          title: title,
          endpoint: uri,
        );
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
