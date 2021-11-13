import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_hexes_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import 'colors_search_closest_entry_test.dart';

class ColorsSearchHexesEntryTester extends EntryTester<ColorsSearchHexesEntry> {
  const ColorsSearchHexesEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_search_hexes",
        "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
        "entries": [
          {
            "title": "colors_search_closest",
            "endpoint": "https://test.com/colors/search/hexes/closest?hex={hex}"
          }
        ]
      };

  @override
  void assertExpectations(ColorsSearchHexesEntry entry) {
    final expectedPathSegments = ["colors", "search", "hexes"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_search_hexes",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["hex"],
    );
    final searchClosestTester = ColorsSearchClosestEntryTester(testRunner);
    final searchClosestEntry = entry.closest;
    assertChildEntryExpectations(
      entryTester: searchClosestTester,
      entry: searchClosestEntry,
    );
  }
}

void main() {
  group("Given a $ColorsSearchHexesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSearchHexesEntryTester(testRunner);
        final entry = ColorsSearchHexesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = ColorsSearchHexesEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
