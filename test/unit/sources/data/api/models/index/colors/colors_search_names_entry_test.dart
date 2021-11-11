import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_names_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/api_index_entry_test_runner.dart';
import '../../../test_helpers/entry_tester.dart';

class ColorsSearchNamesEntryTester extends EntryTester<ColorsSearchNamesEntry> {
  const ColorsSearchNamesEntryTester(ApiIndexEntryTestRunner testRunner)
      : super(testRunner);

  @override
  Map<String, dynamic> get testMap => {
        "title": "colors_search_names",
        "endpoint": "https://test.com/colors/search/names?name={name}"
      };

  @override
  void assertExpectations(ColorsSearchNamesEntry entry) {
    final expectedPathSegments = ["colors", "search", "names"];
    testRunner.assertExpectations(
      entry,
      expectedTitle: "colors_search_names",
      expectedPathSegments: expectedPathSegments,
      expectedParameterKeys: ["name"],
    );
  }
}

void main() {
  group("Given a $ColorsSearchNamesEntry", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const tester = ColorsSearchNamesEntryTester(testRunner);
        final entry = ColorsSearchNamesEntry.fromJson(tester.testMap);
        tester.assertExpectations(entry);
      });
    });

    group("when constructed from the constructor", () {
      test("then values can be correctly retrieved", () {
        final uri = Uri.parse("https://test.com");
        const title = "test";
        final entry = ColorsSearchNamesEntry(title: title, endpoint: uri);
        expect(entry.endpoint, uri);
        expect(entry.title, title);
      });
    });
  });
}
