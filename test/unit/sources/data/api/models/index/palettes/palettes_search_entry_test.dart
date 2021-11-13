import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_search_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';
import 'palettes_search_names_entry_test.dart';

class PalettesSearchEntryTester extends EntryTester<PalettesSearchEntry> {
  const PalettesSearchEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "palettes_search",
        "entries": [
          {
            "title": "palettes_search_names",
            "endpoint": "https://test.com/palettes/search/names?name={name}"
          }
        ]
      };

  @override
  void assertExpectations(PalettesSearchEntry entry) {
    testRunner.assertExpectations(entry, expectedTitle: "palettes_search");
    final searchNamesTester = PalettesSearchNamesEntryTester(testRunner);
    final searchNamesEntry = entry.names;
    assertChildEntryExpectations(
      entryTester: searchNamesTester,
      entry: searchNamesEntry,
    );
  }
}

void main() {
  group("Given a $PalettesSearchEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesSearchEntryTester(testRunner);
        final entry = PalettesSearchEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = PalettesSearchEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
