import 'package:colored/sources/common/extensions/map_string_safe_access.dart';

class ApiIndexEntry {
  const ApiIndexEntry({required this.endpoint, required this.title});

  ApiIndexEntry.fromJson(Map<String, String> json)
      : title = json.valueFor(ApiIndexEntry.titleKey),
        endpoint = Uri.parse(json.valueFor(ApiIndexEntry.endpointKey));

  static const String titleKey = "title";
  static const String endpointKey = "endpoint";

  final String title;
  final Uri endpoint;
}
