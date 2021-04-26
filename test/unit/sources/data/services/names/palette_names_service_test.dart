import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/map_filter/map_filter.dart';
import 'package:colored/sources/data/services/map_filter/palette_filter.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:flutter_test/flutter_test.dart';

class PalettesDataLoaderStub implements DataLoader<List<String>> {
  static const mockPalettes = {
    "Test": ["000000", "ffffff"]
  };

  @override
  Future<Map<String, List<String>>> load() async => mockPalettes;
}

void main() {
  late PaletteNamesService service;
  late DataLoader<List<String>> dataLoader;
  late MapFilter<List<String>> filter;

  setUp(() {
    dataLoader = PalettesDataLoaderStub();
    filter = const PaletteFilter();
    service = PaletteNamesService(dataLoader: dataLoader, filter: filter);
  });

  group("Given a PaletteNamesService with a mocked data source", () {
    group("when fetchContainingSearch is called", () {
      test("then the palette can be found by its name", () async {
        final actual = await service.fetchContainingSearch("Test");
        expect(actual, PalettesDataLoaderStub.mockPalettes);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = await service.fetchContainingSearch("Black");
        expect(actual, {});
      });
    });
  });
}
