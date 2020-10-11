import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given an HttpResponse", () {
    group("when constructed", () {
      test("then an assertion error is thrown if the status is null", () {
        expect(
          () => HttpResponse(status: null),
          throwsAssertionError,
        );
      });
    });
  });
}
