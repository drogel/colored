import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_search_names_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';

class PalettesSearchNamesEntryTester
    extends EntryTester<PalettesSearchNamesEntry> {
  const PalettesSearchNamesEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "palettes_search_names",
        "endpoint": "https://test.com/palettes/search/names?name={name}"
      };

  @override
  void assertExpectations(PalettesSearchNamesEntry entry) {
    final expectedPathSegments = ["palettes", "search", "names"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "palettes_search_names",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["name"],
    );
  }
}

void main() {
  group("Given a $PalettesSearchNamesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = PalettesSearchNamesEntryTester(testRunner);
        final entry = PalettesSearchNamesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
