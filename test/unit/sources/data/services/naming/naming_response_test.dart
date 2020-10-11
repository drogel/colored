import 'package:colored/sources/data/services/naming/naming_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a NamingResponse", () {
    group("when constructed", () {
      test("then an assertion error is thrown if status is null", () {
        expect(() => NamingResponse(null), throwsAssertionError);
      });
    });
  });
}
