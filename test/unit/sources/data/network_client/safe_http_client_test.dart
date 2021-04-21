import 'dart:async';
import 'dart:io';

import 'package:colored/sources/data/network_client/http_client.dart';
import 'package:colored/sources/data/network_client/http_response.dart';
import 'package:colored/sources/data/network_client/http_wrapper.dart';
import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

class TimeoutHttpWrapper implements HttpWrapper {
  const TimeoutHttpWrapper();

  static const timeoutForcingSeconds = SafeHttpClient.timeoutLimitSeconds + 1;

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) =>
      Future.delayed(const Duration(seconds: timeoutForcingSeconds));
}

class SocketExceptionHttpWrapper implements HttpWrapper {
  const SocketExceptionHttpWrapper();

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) =>
      throw SocketException(runtimeType.toString());
}

class ResponseHttpWrapper implements HttpWrapper {
  const ResponseHttpWrapper();

  static const responseBody = "test";
  static const responseStatus = 200;

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) async =>
      Response(responseBody, responseStatus);
}

void main() {
  final _kValidHttpResponse = Response("testBody", 200);
  HttpClient? client;

  group("Given a SafeHttpClient", () {
    setUp(() {
      client = const SafeHttpClient();
    });

    tearDown(() {
      client = null;
    });

    group("when constructed", () {
      test("then throws an assertion error if httpWrapper is null", () {
        expect(
          () => SafeHttpClient(httpWrapper: null),
          throwsAssertionError,
        );
      });
    });

    group("when isResponseOk is called", () {
      test("then returns true if status=okay, code=200 and body!=null", () {
        final validResponse = HttpResponse(
          status: ResponseStatus.ok,
          httpResponse: _kValidHttpResponse,
        );
        final actual = client!.isResponseOk(validResponse);
        expect(actual, isTrue);
      });

      test("then returns false if status is not okay", () {
        final invalidResponse = HttpResponse(
          status: ResponseStatus.failed,
          httpResponse: _kValidHttpResponse,
        );
        final actual = client!.isResponseOk(invalidResponse);
        expect(actual, isFalse);
      });

      test("then returns false if http status code is not 200", () {
        final invalidResponse = HttpResponse(
          status: ResponseStatus.ok,
          httpResponse: Response("testBody", 400),
        );
        final actual = client!.isResponseOk(invalidResponse);
        expect(actual, isFalse);
      });
    });
  });

  group("Given a SafeHttpClient with a timeout-throwing http wrapper", () {
    setUp(() {
      client = const SafeHttpClient(httpWrapper: TimeoutHttpWrapper());
    });

    tearDown(() {
      client = null;
    });

    group("when get is called", () {
      test("then a failed status is returned on timeout", () {
        fakeAsync((async) {
          client!
              .get("test")
              .then((actual) => expect(actual.status, ResponseStatus.failed));
          async.elapse(
            const Duration(seconds: TimeoutHttpWrapper.timeoutForcingSeconds),
          );
        });
      });
    });
  });

  group("Given a SafeHttpClient with a socket exception-throwing wrapper", () {
    setUp(() {
      client = const SafeHttpClient(httpWrapper: SocketExceptionHttpWrapper());
    });

    tearDown(() {
      client = null;
    });

    group("when get is called", () {
      test("then a failed status is returned on socket exception", () async {
        final actual = await client!.get("test");
        expect(actual.status, ResponseStatus.failed);
      });
    });
  });

  group("Given a SafeHttpClient with a valid response-giving wrapper", () {
    setUp(() {
      client = const SafeHttpClient(httpWrapper: ResponseHttpWrapper());
    });

    tearDown(() {
      client = null;
    });

    group("when get is called", () {
      test("then an ok status is recieved with the response", () async {
        final actual = await client!.get("test");
        final response = actual.httpResponse!;
        expect(actual.status, ResponseStatus.ok);
        expect(response.body, ResponseHttpWrapper.responseBody);
        expect(response.statusCode, ResponseHttpWrapper.responseStatus);
      });
    });
  });
}
