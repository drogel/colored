import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/names/palette_names_service.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPalettesDataLoader implements DataLoader {
  static const mockPalettes = {
    "Test": ["000000", "ffffff"]
  };

  @override
  Future<Map<String, List<String>>> load() async => mockPalettes;
}

void main() {
  PaletteNamesService service;
  DataLoader dataLoader;

  setUp(() {
    dataLoader = MockPalettesDataLoader();
    service = PaletteNamesService(dataLoader: dataLoader);
  });

  tearDown(() {
    dataLoader = null;
    service = null;
  });

  group("Given a PaletteNamesService with a mocked data source", () {
    group("when constructed", () {
      test("then should throw if given dataLoader name", () {
        expect(
          () => PaletteNamesService(dataLoader: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when fetchNamesContaining is called", () {
      test("then the palette can be found by its name", () async {
        final actual = await service.fetchNamesContaining("Test");
        expect(actual, MockPalettesDataLoader.mockPalettes);
      });

      test("then an empty map is returned if search missed", () async {
        final actual = await service.fetchNamesContaining("Black");
        expect(actual, {});
      });
    });
  });
}
