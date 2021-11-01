import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_entry.dart';

class ColorsEntry extends ApiIndexEntry {
  const ColorsEntry({
    required String title,
    required Uri? endpoint,
    this.search,
  }) : super(title: title, endpoint: endpoint);

  ColorsEntry.fromJson(Map<String, dynamic> json)
      : search = getSearchIfAny(json),
        super.fromJson(json);

  final ColorsSearchEntry? search;

  static ColorsSearchEntry? getSearchIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) => ColorsSearchEntry.fromJson(childMap),
      );
}
