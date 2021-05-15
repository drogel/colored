import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_closest_entry.dart';
import 'package:colored/sources/common/extensions/list_safe_element_at_index.dart';

class ColorsSearchHexesEntry extends ApiIndexEntry {
  const ColorsSearchHexesEntry({
    required Uri endpoint,
    required String title,
    this.closest,
  }) : super(endpoint: endpoint, title: title);

  ColorsSearchHexesEntry.fromJson(Map<String, dynamic> json)
      : closest = getClosestIfAny(json),
        super.fromJson(json);

  final ColorsSearchClosestEntry? closest;

  static ColorsSearchClosestEntry? getClosestIfAny(Map<String, dynamic> json) {
    final entries = ApiIndexEntry.getEntriesFromJson(json);
    final closest = entries.safeElementAt(0);
    return closest != null ? ColorsSearchClosestEntry.fromJson(closest) : null;
  }
}
