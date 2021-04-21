import 'package:colored/sources/data/services/map_filter/color_names_filter.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter_test/flutter_test.dart';

class NamesDataSourceStub implements DataLoader<String> {
  static const mockColorNames = {"212121": "Sample Color"};

  @override
  Future<Map<String, String>> load() async => mockColorNames;
}

void main() {
  DataLoader? dataLoader;
  NamesService? namesService;
  late MapFilter filter;

  setUp(() {
    dataLoader = NamesDataSourceStub();
    filter = const ColorNamesFilter();
    namesService = ColorNamesService(
      dataLoader: dataLoader!,
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
          throwsAssertionError,
        );
      });

      test("then should throw if given null filter", () {
        expect(
          () => ColorNamesService(dataLoader: dataLoader!, filter: null),
          throwsAssertionError,
        );
      });
    });

    group("when fetchContainingSearch is called", () {
      test("then the color can be found by its hex code", () async {
        final actual = await namesService!.fetchContainingSearch("2121");
        expect(actual, NamesDataSourceStub.mockColorNames);
      });

      test("then the color can be found by its name", () async {
        final actual = await namesService!.fetchContainingSearch("Sample");
        expect(actual, NamesDataSourceStub.mockColorNames);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = await namesService!.fetchContainingSearch("Black");
        expect(actual, {});
      });
    });
  });
}
