import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/api_index_entry_test_runner.dart';
import '../../test_helpers/test_api_index_response.dart';
import 'colors/colors_entry_test.dart';
import 'palettes/palettes_entry_test.dart';
import 'suggestions/suggestions_entry_test.dart';

void main() {
  group("Given an $ApiIndex", () {
    group("when constructed from a JSON", () {
      test("then values are correctly parsed", () {
        const testRunner = ApiIndexEntryTestRunner();
        const colorsTester = ColorsEntryTester(testRunner);
        const palettesTester = PalettesEntryTester(testRunner);
        const suggestionsTester = SuggestionsEntryTester(testRunner);
        final apiIndex = ApiIndex.fromJsonEntries(testIndex);
        final colors = apiIndex.colors;
        final palettes = apiIndex.palettes;
        final suggestions = apiIndex.suggestions;

        if (colors != null && palettes != null && suggestions != null) {
          colorsTester.assertExpectations(colors);
          palettesTester.assertExpectations(palettes);
          suggestionsTester.assertExpectations(suggestions);
        } else {
          fail("$ApiIndex parsing failed, expected all entries != null.");
        }
      });
    });
  });
}
