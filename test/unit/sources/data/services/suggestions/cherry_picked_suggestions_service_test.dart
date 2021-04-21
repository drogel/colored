import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/int_generator/int_generator.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:flutter_test/flutter_test.dart';

class ColorSuggestionsLoaderStub implements DataLoader<String> {
  static const mockSuggestions = {
    "111111": "First",
    "222222": "Second",
    "333333": "Third",
    "444444": "Fourth",
  };

  @override
  Future<Map<String, String>> load() async => mockSuggestions;
}

class PaletteSuggestionsLoaderStub implements DataLoader<List<String>> {
  static const mockSuggestions = <String, List<String>>{
    "First": [],
    "Second": ["000000", "ffffff"],
    "Third": [],
    "Fourth": ["000000"],
  };

  @override
  Future<Map<String, List<String>>> load() async => mockSuggestions;
}

class RandomGeneratorStub implements IntGenerator {
  static const stubbedIntList = [1, 3];

  @override
  List<int> generate({int? max, int? length}) => stubbedIntList;
}

void main() {
  group("Given a CherryPickedSuggestionsService", () {
    group("when constructed", () {
      test("then an assertion error is thrown if dataLoader is null", () {
        expect(
            () => CherryPickedSuggestionsService(
                  dataLoader: null,
                  listPicker: StringListPicker(
                    intGenerator: RandomGeneratorStub(),
                  ),
                ),
            throwsAssertionError);
      });

      test("then an assertion error is thrown if listPicker is null", () {
        expect(
            () => CherryPickedSuggestionsService(
                  dataLoader: ColorSuggestionsLoaderStub(),
                  listPicker: null,
                ),
            throwsAssertionError);
      });
    });
  });

  group("Given a CherryPickedSuggestionsService with a color data loader", () {
    DataLoader<String>? suggestionsDataLoader;
    SuggestionsService<String?>? suggestionsService;

    setUp(() {
      suggestionsDataLoader = ColorSuggestionsLoaderStub();
      suggestionsService = CherryPickedSuggestionsService<String>(
        dataLoader: suggestionsDataLoader!,
        listPicker: StringListPicker(
          intGenerator: RandomGeneratorStub(),
        ),
      );
    });

    tearDown(() {
      suggestionsDataLoader = null;
      suggestionsService = null;
    });

    group("when fetchSuggestions is called", () {
      test("then the expected map is retrieved", () async {
        final actual = await suggestionsService!.fetchSuggestions(2);
        final expected = {"222222": "Second", "444444": "Fourth"};
        expect(actual, expected);
      });
    });
  });

  group("Given a CherryPickerSuggestionsService with a palette loader", () {
    DataLoader<List<String>>? suggestionsDataLoader;
    SuggestionsService<List<String>?>? suggestionsService;

    setUp(() {
      suggestionsDataLoader = PaletteSuggestionsLoaderStub();
      suggestionsService = CherryPickedSuggestionsService<List<String>>(
        dataLoader: suggestionsDataLoader!,
        listPicker: StringListPicker(
          intGenerator: RandomGeneratorStub(),
        ),
      );
    });

    tearDown(() {
      suggestionsDataLoader = null;
      suggestionsService = null;
    });

    group("when fetchSuggestions is called", () {
      test("then the exected palette map is retrieved", () async {
        final actual = await suggestionsService!.fetchSuggestions(2);
        final expected = <String, List<String>>{
          "Second": ["000000", "ffffff"],
          "Fourth": ["000000"]
        };
        expect(actual, expected);
      });
    });
  });
}
