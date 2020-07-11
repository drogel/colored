import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNamesDataSource implements DataLoader {
  static const mockColorNames = {"212121": "Sample Color"};

  @override
  Future<Map<String, String>> load() async => mockColorNames;
}

void main() {
  DataLoader dataLoader;
  NamesService namesService;
  MapFilter filter;

  setUp(() {
    dataLoader = MockNamesDataSource();
    filter = const ColorNamesFilter();
    namesService = ColorNamesService(
      dataLoader: dataLoader,
      filter: filter,
    );
  });

  tearDown(() {
    dataLoader = null;
    namesService = null;
  });

  group("Given a ColorNamesService with a mocked data source", () {
    group("when constructed", () {
      test("then should throw if given null dataLoader", () {
        expect(
          () => ColorNamesService(dataLoader: null, filter: filter),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then should throw if given null filter", () {
        expect(
          () => ColorNamesService(dataLoader: dataLoader, filter: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when fetchNamesContaining is called", () {
      test("then the color can be found by its hex code", () async {
        final actual = await namesService.fetchNamesContaining("2121");
        expect(actual, MockNamesDataSource.mockColorNames);
      });

      test("then the color can be found by its name", () async {
        final actual = await namesService.fetchNamesContaining("Sample");
        expect(actual, MockNamesDataSource.mockColorNames);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = await namesService.fetchNamesContaining("Black");
        expect(actual, {});
      });
    });
  });
}
