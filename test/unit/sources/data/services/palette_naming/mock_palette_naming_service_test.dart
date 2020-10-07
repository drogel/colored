import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PaletteNamingService mockService;

  setUp(() {
    mockService = const MockPaletteNamingService();
  });

  tearDown(() {
    mockService = null;
  });

  group("Given a MockPaletteNamingService", () {
    group("when getNaming is called", () {
      test("then a response status ok is retrieved", () async {
        final actual = await mockService.getNaming(hexColors: []);
        expect(actual.status, ResponseStatus.ok);
      });

      test("then color amount from sample palette is retrieved", () async {
        final actual = await mockService.getNaming(hexColors: []);
        expect(actual.results.length, 5);
      });

      test("then the sample colors are retrieved", () async {
        final actual = await mockService.getNaming(hexColors: []);
        expect(actual.results.first.name, "Lead");
        expect(actual.results.first.hex, "#212121");
        expect(actual.results.first.r, 33);
      });
    });
  });
}
