import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_closest_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_hexes_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_tester.dart';

void main() {
  const testMap = {
    "title": "colors_search_hexes",
    "endpoint": "https://test.com/colors/search/hexes?hex={hex}",
    "entries": [
      {
        "title": "colors_search_closest",
        "endpoint": "https://test.com/colors/search/hexes/closest?hex={hex}"
      }
    ]
  };

  group("Given a $ColorsSearchHexesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const tester = ApiIndexEntryTester();
        final entry = ColorsSearchHexesEntry.fromJson(testMap);
        final expectedPathSegments = ["colors", "search", "hexes"];
        tester.assertExpectations(
          entry,
          expectedTitle: "colors_search_hexes",
          expectedPathSegments: expectedPathSegments,
          expectedParameterKeys: ["hex"],
        );
      });
    });
  });
}
