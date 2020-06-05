import 'package:colored/sources/data/services/names/names_data_source/names_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNamesDataSource implements NamesDataSource {
  @override
  Future<Map<String, String>> loadNames() async {
    throw UnimplementedError();
  }
}

void main() {
  setUp(() {
    // TODO(diego): implement setUp method in color_names_service_test
  });

  tearDown(() {
    // TODO(diego): implement tearDown method in color_names_service_test
  });

  group("", () {
    test("", () {
      // TODO(diego): define unit tests in color_names_service_test
    });
  });
}