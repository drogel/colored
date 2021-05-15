extension MapStringSafeAccess on Map<String, dynamic> {
  String stringValueFor(String key) {
    final value = this[key];
    return value is String ? value : "";
  }

  List<T> listValueFor<T>(String key) {
    final value = this[key];
    return value is List<T> ? value : [];
  }
}
