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
  DataLoader namesDataSource;
  NamesService namesService;

  setUp(() {
    namesDataSource = MockNamesDataSource();
    namesService = ColorNamesService(dataLoader: namesDataSource);
  });

  tearDown(() {
    namesDataSource = null;
    namesService.dispose();
    namesService = null;
  });

  group("Given a ColorNamesService with a mocked data source", () {
    group("when fetchColorNames is called", () {
      test("then the color can be found by its hex code", () async {
        await namesService.loadNames();
        final actual = namesService.fetchNamesContaining("2121");
        expect(actual, MockNamesDataSource.mockColorNames);
      });

      test("then the color can be found by its name", () async {
        await namesService.loadNames();
        final actual = namesService.fetchNamesContaining("Sample");
        expect(actual, MockNamesDataSource.mockColorNames);
      });

      test("then an empty map is returned if search missed", () async {
        await namesService.loadNames();
        final actual = namesService.fetchNamesContaining("Black");
        expect(actual, {});
      });
    });
  });
}