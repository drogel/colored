import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/int_generator/int_generator.dart';
import 'package:colored/sources/data/services/suggestions/color_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSuggestionsDataLoader implements DataLoader {
  static const mockSuggestions = {
    "111111": "First",
    "222222": "Second",
    "333333": "Third",
    "444444": "Fourth",
  };

  @override
  Future<Map<String, String>> load() async => mockSuggestions;
}

class RandomGeneratorStub implements IntGenerator {
  static const stubbedIntList = [1, 3];

  @override
  List<int> generate({int max, int length}) => stubbedIntList;
}

void main() {
  DataLoader suggestionsDataLoader;
  SuggestionsService suggestionsService;

  setUp(() {
    suggestionsDataLoader = MockSuggestionsDataLoader();
    suggestionsService = ColorSuggestionsService(
      dataLoader: suggestionsDataLoader,
      listPicker: StringListPicker(
        intGenerator: RandomGeneratorStub(),
      ),
    );
  });

  tearDown(() {
    suggestionsDataLoader = null;
    suggestionsService.dispose();
    suggestionsService = null;
  });

  group("Given a ColorSuggestionsService with a mocked data loader", () {
    group("when fetchRandomSuggestions is called", () {
      test("then the expected map is retrieved", () async {
        await suggestionsService.loadSuggestions();
        final actual = suggestionsService.fetchRandomSuggestions(0);
        final expected = {"222222": "Second", "444444": "Fourth"};
        expect(actual, expected);
      });
    });
  });
}
