import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PaletteNamingService mockService;
  late PaletteNamingResponse response;

  setUp(() async {
    mockService = const MockPaletteNamingService();
    response = await mockService.getNaming(hexColors: []);
  });

  group("Given a MockPaletteNamingService", () {
    group("when getNaming is called", () {
      test("then a response status ok is retrieved", () async {
        expect(response.status, ResponseStatus.ok);
      });

      test("then color amount from sample palette is retrieved", () async {
        final results = response.results;
        if (results != null) {
          expect(results.length, 5);
        } else {
          fail("Results from the response in this test should never be null");
        }
      });

      test("then the sample colors are retrieved", () async {
        final results = response.results;
        if (results != null) {
          expect(results.first.name, "Lead");
          expect(results.first.hex, "#212121");
          expect(results.first.r, 33);
        } else {
          fail("Results from the response in this test should never be null");
        }
      });

      test("then the named colors have uppercase hex codes", () async {
        final results = response.results;
        if (results != null) {
          expect(results[2].hex, "#FF0011");
        } else {
          fail("Results from the response in this test should never be null");
        }
      });
    });
  });
}
