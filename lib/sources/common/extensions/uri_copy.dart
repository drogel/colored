extension UriCopy on Uri {
  Uri copy({
    String? scheme,
    String? userInfo,
    String? host,
    int? port,
    String? path,
    Map<String, dynamic>? queryParameters,
    String? fragment,
  }) =>
      Uri(
        scheme: scheme ?? this.scheme,
        userInfo: userInfo ?? this.userInfo,
        host: host ?? this.host,
        port: port ?? this.port,
        path: path ?? this.path,
        queryParameters: queryParameters ?? this.queryParameters,
        fragment: fragment ?? this.fragment,
      );
}
