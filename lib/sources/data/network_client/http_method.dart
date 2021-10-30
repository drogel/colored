enum HttpMethod {
  get,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
  unknown,
}

class HttpMethodBuilder {
  static HttpMethod fromString(String stringValue) {
    final httpMethod = HttpMethod.values.firstWhere(
      (method) => method.stringValue == stringValue,
      orElse: () => HttpMethod.unknown,
    );
    return httpMethod;
  }
}

extension HttpMethodStrings on HttpMethod {
  String get stringValue {
    switch (this) {
      case HttpMethod.get:
        return "GET";
      case HttpMethod.post:
        return "POST";
      case HttpMethod.put:
        return "PUT";
      case HttpMethod.delete:
        return "DELETE";
      case HttpMethod.connect:
        return "CONNECT";
      case HttpMethod.options:
        return "OPTIONS";
      case HttpMethod.trace:
        return "TRACE";
      case HttpMethod.patch:
        return "PATCH";
      case HttpMethod.unknown:
        return "UKNOWN";
    }
  }
}
