import 'dart:convert';

import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/naming/meodai_naming_service.dart';
import 'package:colored/sources/data/services/url_composer/url_composer.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../network_client/test_helpers/http_client_stubs.dart';

class UrlComposerStub implements UrlComposer {
  const UrlComposerStub();

  static const url = "testUrl";

  @override
  String compose(String baseUrl, {String? path}) => "testUrl";
}

const testNamingResponseBody = {
  "colors": [
    {
      "name": "test",
      "hex": "#000000",
      "rgb": {"r": 0, "g": 0, "b": 0},
      "hsl": {"h": 0, "s": 0, "l": 0},
      "luminance": 0,
      "requestedHex": "#000000",
      "distance": 0
    }
  ]
};

void main() {
  late MeodaiNamingService service;

  group("Given a $MeodaiNamingService", () {
    setUp(() {
      service = MeodaiNamingService(
        urlComposer: const UrlComposerStub(),
        networkClient: HttpClientSuccessfulStub(
          responseBody: jsonEncode(testNamingResponseBody),
        ),
      );
    });

    group("when getNaming is called", () {
      test("then successful response returned on hexColors", () async {
        final actual = await service.getNaming(hexColor: "test");
        expect(actual.status, ResponseStatus.ok);
        expect(actual.result, const NamingResult(name: "test", hex: "#000000"));
      });
    });
  });

  group("Given a MeodaiPaletteNamingService with a failing client", () {
    setUp(() {
      service = const MeodaiNamingService(
        urlComposer: UrlComposerStub(),
        networkClient: HttpClientFailingStub(),
      );
    });

    group("when getNaming is called", () {
      test("then a failed response is retrieved", () async {
        final actual = await service.getNaming(hexColor: "test");
        expect(actual.status, ResponseStatus.failed);
      });
    });
  });
}
