import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/data/services/naming/naming_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  NamingService? namingService;

  setUp(() {
    namingService = const MockNamingService();
  });

  tearDown(() {
    namingService = null;
  });

  group("Given a MockNamingService", () {
    group("when fetchNaming is called for any hexColor", () {
      test("then expected sample color is retrieved", () async {
        final namingResponse = await namingService!.getNaming(hexColor: "");
        final result = namingResponse.result!;
        expect(namingResponse.status, ResponseStatus.ok);
        expect(result.hex, "#212121");
        expect(result.name, "Sample Color");
      });
    });
  });
}