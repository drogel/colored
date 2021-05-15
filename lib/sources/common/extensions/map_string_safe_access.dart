extension MapStringSafeAccess on Map<String, String> {
  String valueFor(String key) => this[key] ?? "";
}
