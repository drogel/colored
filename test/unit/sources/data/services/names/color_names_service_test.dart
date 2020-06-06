import 'package:colored/sources/data/services/names/color_names_service.dart';
import 'package:colored/sources/data/services/names/names_data_source/names_data_source.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNamesDataSource implements NamesDataSource {
  static const mockColorNames = {"212121": "Sample Color"};

  @override
  Future<Map<String, String>> loadNames() async => mockColorNames;
}

void main() {
  NamesDataSource namesDataSource;
  NamesService namesService;

  setUp(() {
    namesDataSource = MockNamesDataSource();
    namesService = ColorNamesService(dataSource: namesDataSource);
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