import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/services/palette_naming/meodai_palette_naming_service.dart';
import 'package:colored/sources/data/services/palette_naming/palette_naming_service.dart';
import 'package:colored/sources/data/services/url_composer/url_composer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class UrlComposerStub implements UrlComposer {
  const UrlComposerStub();

  static const url = "testUrl";

  @override
  String compose(String baseUrl, {String? path}) => "testUrl";
}

class HttpClientSuccessfulStub implements HttpClient {
  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    final httpResponse = http.Response('{"colors": []}', 200);
    return HttpResponse(status: ResponseStatus.ok, httpResponse: httpResponse);
  }

  @override
  bool isResponseOk(HttpResponse response) => true;
}

class HttpClientFailingStub implements HttpClient {
  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async =>
      const HttpResponse(status: ResponseStatus.failed);

  @override
  bool isResponseOk(HttpResponse response) => false;
}

void main() {
  late PaletteNamingService service;

  group("Given a MeodaiPaletteNamingService", () {
    setUp(() {
      service = MeodaiPaletteNamingService(
        urlComposer: const UrlComposerStub(),
        networkClient: HttpClientSuccessfulStub(),
      );
    });

    group("when getNaming is called", () {
      test("then a failed response is returned on empty hexColors", () async {
        final actual = await service.getNaming(hexColors: []);
        expect(actual.status, ResponseStatus.failed);
      });

      test("then successful response returned on hexColors", () async {
        final actual = await service.getNaming(hexColors: ["test"]);
        expect(actual.status, ResponseStatus.ok);
        expect(actual.results, []);
      });
    });
  });

  group("Given a MeodaiPaletteNamingService with a failing client", () {
    setUp(() {
      service = MeodaiPaletteNamingService(
        urlComposer: const UrlComposerStub(),
        networkClient: HttpClientFailingStub(),
      );
    });

    group("when getNaming is called", () {
      test("then a failed response is retrieved", () async {
        final actual = await service.getNaming(hexColors: ["test"]);
        expect(actual.status, ResponseStatus.failed);
      });
    });
  });
}
