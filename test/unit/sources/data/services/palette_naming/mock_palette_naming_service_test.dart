import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PaletteNamingService mockService;
  PaletteNamingResponse response;

  setUp(() async {
    mockService = const MockPaletteNamingService();
    response = await mockService.getNaming(hexColors: []);
  });

  tearDown(() {
    mockService = null;
    response = null;
  });

  group("Given a MockPaletteNamingService", () {
    group("when getNaming is called", () {
      test("then a response status ok is retrieved", () async {
        expect(response.status, ResponseStatus.ok);
      });

      test("then color amount from sample palette is retrieved", () async {
        expect(response.results.length, 5);
      });

      test("then the sample colors are retrieved", () async {
        expect(response.results.first.name, "Lead");
        expect(response.results.first.hex, "#212121");
        expect(response.results.first.r, 33);
      });

      test("then the named colors have uppercase hex codes", () async {
        expect(response.results[2].hex, "#FF0011");
      });
    });
  });
}
