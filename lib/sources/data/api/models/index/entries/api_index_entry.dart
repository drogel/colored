import 'package:colored/sources/common/extensions/list_safe_element_at_index.dart';
import 'package:colored/sources/common/extensions/map_safe_access.dart';

class ApiIndexEntry {
  const ApiIndexEntry({required this.title, this.endpoint});

  ApiIndexEntry.fromJson(Map<String, dynamic> json)
      : title = json.stringValueFor(_Key.title.value),
        endpoint = parseEndpoint(json);

  final String title;
  final Uri? endpoint;

  static Uri? parseEndpoint(Map<String, dynamic> json) {
    if (!json.keys.contains(_Key.endpoint.value)) {
      return null;
    }
    return Uri.parse(json.stringValueFor(_Key.endpoint.value));
  }

  static T? getChildEntryAtIndexIfAny<T extends ApiIndexEntry>(
    int index, {
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) entryBuilder,
  }) {
    final entries = json.listValueFor<Map<String, dynamic>>(_Key.entries.value);
    final childEntryMap = entries.safeElementAt(index);
    return childEntryMap != null ? entryBuilder(childEntryMap) : null;
  }
}

enum _Key {
  title,
  endpoint,
  entries,
}

extension _KeyValues on _Key {
  String get value {
    switch (this) {
      case _Key.title:
        return "title";
      case _Key.endpoint:
        return "endpoint";
      case _Key.entries:
        return "entries";
    }
  }
}
