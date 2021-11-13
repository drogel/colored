import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import 'colors_search_hexes_entry_test.dart';
import 'colors_search_names_entry_test.dart';

class ColorsSearchEntryTester extends EntryTester<ColorsSearchEntry> {
  const ColorsSearchEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
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
      };

  @override
  void assertExpectations(ColorsSearchEntry entry) {
    testRunner.assertExpectations(entry, expectedTitle: "colors_search");
    final searchHexesTester = ColorsSearchHexesEntryTester(testRunner);
    final searchHexesEntry = entry.hexes;
    assertChildEntryExpectations(
      entryTester: searchHexesTester,
      entry: searchHexesEntry,
    );
    final searchNamesTester = ColorsSearchNamesEntryTester(testRunner);
    final searchNamesEntry = entry.names;
    assertChildEntryExpectations(
      entryTester: searchNamesTester,
      entry: searchNamesEntry,
    );
  }
}

void main() {
  group("Given a $ColorsSearchEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSearchEntryTester(testRunner);
        final entry = ColorsSearchEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = ColorsSearchEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
