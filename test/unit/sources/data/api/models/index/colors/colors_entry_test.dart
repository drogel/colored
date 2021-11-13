import 'package:colored/sources/data/api/models/index/entries/colors/colors_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import 'colors_search_entry_test.dart';

class ColorsEntryTester extends EntryTester<ColorsEntry> {
  const ColorsEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
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
      };

  @override
  void assertExpectations(ColorsEntry entry) {
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors",
      expectedPathSegments: ["colors", "{hex}"],
    );
    final searchTester = ColorsSearchEntryTester(testRunner);
    final searchEntry = entry.search;
    assertChildEntryExpectations(entryTester: searchTester, entry: searchEntry);
  }
}

void main() {
  group("Given a $ColorsEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsEntryTester(testRunner);
        final entry = ColorsEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = ColorsEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
