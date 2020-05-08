import 'package:colored/sources/data/services/api_response.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  NamingService namingService;

  setUp(() {
    namingService = const MockNamingService();
  });

  tearDown(() {
    namingService = null;
  });

  group("Given a MockNamingService", () {
    group("when fetchNaming is called for any hexColor", () {
      test("then expected sample color is retrieved", () async {
        final namingResponse = await namingService.fetchNaming(hexColor: "");
        final result = namingResponse.result;
        expect(namingResponse.response, ApiResponse.ok);
        expect(result.hex, "#212121");
        expect(result.name, "Sample Color");
      });
    });
  });
}