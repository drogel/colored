import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import 'palettes_search_entry_test.dart';

class PalettesEntryTester extends EntryTester<PalettesEntry> {
  const PalettesEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
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
      };

  @override
  void assertExpectations(PalettesEntry entry) {
    testRunner.assertExpectations(
      entry,
      expectedTitle: "palettes",
      expectedPathSegments: ["palettes", "{id}"],
    );
    final searchTester = PalettesSearchEntryTester(testRunner);
    final searchEntry = entry.search;
    assertChildEntryExpectations(entryTester: searchTester, entry: searchEntry);
  }
}

void main() {
  group("Given a $PalettesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesEntryTester(testRunner);
        final entry = PalettesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = PalettesEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
