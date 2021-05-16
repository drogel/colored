import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:flutter_test/flutter_test.dart';

class ApiIndexEntryTestRunner {
  const ApiIndexEntryTestRunner({
    this.scheme = "https",
    this.host = "test.com",
  });

  final String scheme;
  final String host;

  void assertExpectations(
    ApiIndexEntry entry, {
    required String expectedTitle,
    List<String>? expectedPathSegments,
    List<String>? expectedParameterKeys,
  }) {
    final endpoint = entry.endpoint;
    expect(entry.title, expectedTitle);
    if (expectedPathSegments == null) {
      return;
    }
    if (endpoint != null) {
      expect(endpoint.scheme, scheme);
      expect(endpoint.host, host);
      expect(endpoint.pathSegments, expectedPathSegments);
      _expectIfNotNull(endpoint.queryParameters.keys, expectedParameterKeys);
    } else {
      fail("Endpoint should not be null");
    }
  }

  void _expectIfNotNull(actual, expected) {
    if (expected != null) {
      expect(actual, expected);
    }
  }
}
