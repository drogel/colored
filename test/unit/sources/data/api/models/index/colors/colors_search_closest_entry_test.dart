import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_closest_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';

class ColorsSearchClosestEntryTester
    extends EntryTester<ColorsSearchClosestEntry> {
  const ColorsSearchClosestEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, String> get testMap => {
        "title": "colors_search_closest",
        "endpoint": "https://test.com/colors/search/hexes/closest?hex={hex}"
      };

  @override
  void assertExpectations(ColorsSearchClosestEntry entry) {
    final expectedPathSegments = ["colors", "search", "hexes", "closest"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_search_closest",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["hex"],
    );
  }
}

void main() {
  group("Given a $ColorsSearchClosestEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSearchClosestEntryTester(testRunner);
        final entry = ColorsSearchClosestEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });
  });
}
