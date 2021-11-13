extension MapStringSafeAccess on Map<String, dynamic> {
  T? valueFor<T>(String key) {
    final value = this[key];
    return value is T ? value : null;
  }

  String stringValueFor(String key) {
    final value = this[key];
    return value is String ? value : "";
  }

  List<T> listValueFor<T>(String key) {
    final value = this[key];
    return List<T>.from(value);
  }
}
