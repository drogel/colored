import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/int_generator/int_generator.dart';

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
