import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'suggestions_service_test_helper.dart';

void main() {
  group("Given a CherryPickedSuggestionsService with a color data loader", () {
    late DataLoader<String> suggestionsDataLoader;
    late SuggestionsService<String> suggestionsService;

    setUp(() {
      suggestionsDataLoader = ColorSuggestionsLoaderStub();
      suggestionsService = CherryPickedSuggestionsService<String>(
        dataLoader: suggestionsDataLoader,
        listPicker: StringListPicker(
          intGenerator: RandomGeneratorStub(),
        ),
      );
    });

    group("when fetchSuggestions is called", () {
      test("then the expected map is retrieved", () async {
        final actual = await suggestionsService.fetchSuggestions(2);
        final expected = {"222222": "Second", "444444": "Fourth"};
        expect(actual, expected);
      });
    });
  });

  group("Given a CherryPickerSuggestionsService with a palette loader", () {
    late DataLoader<List<String>> suggestionsDataLoader;
    late SuggestionsService<List<String>> suggestionsService;

    setUp(() {
      suggestionsDataLoader = PaletteSuggestionsLoaderStub();
      suggestionsService = CherryPickedSuggestionsService<List<String>>(
        dataLoader: suggestionsDataLoader,
        listPicker: StringListPicker(
          intGenerator: RandomGeneratorStub(),
        ),
      );
    });

    group("when fetchSuggestions is called", () {
      test("then the expected palette map is retrieved", () async {
        final actual = await suggestionsService.fetchSuggestions(2);
        final expected = <String, List<String>>{
          "Second": ["000000", "ffffff"],
          "Fourth": ["000000"]
        };
        expect(actual, expected);
      });
    });
  });
}
