import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_closest_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_tester.dart';

void main() {
  const testMap = {
    "title": "colors_search_closest",
    "endpoint": "https://test.com/colors/search/hexes/closest?hex={hex}"
  };

  group("Given a $ColorsSearchClosestEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const tester = ApiIndexEntryTester();
        final entry = ColorsSearchClosestEntry.fromJson(testMap);
        final expectedPathSegments = ["colors", "search", "hexes", "closest"];
        tester.assertExpectations(
          entry,
          expectedTitle: "colors_search_closest",
          expectedPathSegments: expectedPathSegments,
          expectedParameterKeys: ["hex"],
        );
      });
    });
  });
}
