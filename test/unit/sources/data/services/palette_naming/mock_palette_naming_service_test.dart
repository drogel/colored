import 'package:colored/sources/data/api/services/base/request/api_request_builder.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/palette_naming/mock_palette_naming_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiRequestBuilder<NamedColor> mockService;
  late ListPage<NamedColor>? response;

  setUp(() async {
    mockService = const MockPaletteNamingService();
    response = await mockService.request(
      [],
      pageInfo: const PageInfo(startIndex: 1, size: 5, pageIndex: 1),
    );
  });

  group("Given a MockPaletteNamingService", () {
    group("when request is called", () {
      test("then color amount from sample palette is retrieved", () async {
        final results = response;
        if (results != null) {
          expect(results.items.length, 5);
          expect(results.currentItemCount, 5);
        } else {
          fail("Results from the response in this test should never be null");
        }
      });

      test("then the sample colors are retrieved", () async {
        final results = response;
        if (results != null) {
          expect(results.items.first.name, "Lead");
          expect(results.items.first.hex, "#212121");
        } else {
          fail("Results from the response in this test should never be null");
        }
      });

      test("then the named colors have uppercase hex codes", () async {
        final results = response;
        if (results != null) {
          expect(results.items[2].hex, "#FF0011");
        } else {
          fail("Results from the response in this test should never be null");
        }
      });
    });
  });
}
