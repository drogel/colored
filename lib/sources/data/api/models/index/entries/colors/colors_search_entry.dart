import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_hexes_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_search_names_entry.dart';

class ColorsSearchEntry extends ApiIndexEntry {
  const ColorsSearchEntry({
    required String title,
    Uri? endpoint,
    this.hexes,
    this.names,
  }) : super(title: title, endpoint: endpoint);

  ColorsSearchEntry.fromJson(Map<String, dynamic> json)
      : hexes = getHexesIfAny(json),
        names = getNamesIfAny(json),
        super.fromJson(json);

  final ColorsSearchHexesEntry? hexes;
  final ColorsSearchNamesEntry? names;

  static ColorsSearchHexesEntry? getHexesIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) => ColorsSearchHexesEntry.fromJson(childMap),
      );

  static ColorsSearchNamesEntry? getNamesIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        1,
        json: json,
        entryBuilder: (childMap) => ColorsSearchNamesEntry.fromJson(childMap),
      );
}
