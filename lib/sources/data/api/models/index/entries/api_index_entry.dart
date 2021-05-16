import 'package:colored/sources/common/extensions/list_safe_element_at_index.dart';
import 'package:colored/sources/common/extensions/map_safe_access.dart';

class ApiIndexEntry {
  const ApiIndexEntry({required this.title, this.endpoint});

  ApiIndexEntry.fromJson(Map<String, dynamic> json)
      : title = json.stringValueFor(titleKey),
        endpoint = parseEndpoint(json);

  static const String titleKey = "title";
  static const String endpointKey = "endpoint";
  static const String entriesKey = "entries";

  final String title;
  final Uri? endpoint;

  static Uri? parseEndpoint(Map<String, dynamic> json) {
    if (!json.keys.contains(endpointKey)) {
      return null;
    }
    return Uri.parse(json.stringValueFor(endpointKey));
  }

  static T? getChildEntryAtIndexIfAny<T extends ApiIndexEntry>(
    int index, {
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) entryBuilder,
  }) {
    final entries = json.listValueFor<Map<String, dynamic>>(entriesKey);
    final childEntryMap = entries.safeElementAt(index);
    return childEntryMap != null ? entryBuilder(childEntryMap) : null;
  }
}
