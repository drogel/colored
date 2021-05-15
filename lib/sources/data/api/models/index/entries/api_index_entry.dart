import 'package:colored/sources/common/extensions/map_safe_access.dart';

class ApiIndexEntry {
  const ApiIndexEntry({required this.endpoint, required this.title});

  ApiIndexEntry.fromJson(Map<String, dynamic> json)
      : title = json.stringValueFor(ApiIndexEntry.titleKey),
        endpoint = Uri.parse(json.stringValueFor(ApiIndexEntry.endpointKey));

  static const String titleKey = "title";
  static const String endpointKey = "endpoint";
  static const String entriesKey = "entries";

  final String title;
  final Uri endpoint;

  static List<Map<String, dynamic>> getEntriesFromJson(
    Map<String, dynamic> json,
  ) =>
      json.listValueFor<Map<String, dynamic>>(entriesKey);
}
