import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_search_entry.dart';

class PalettesEntry extends ApiIndexEntry {
  const PalettesEntry({
    required Uri? endpoint,
    required String title,
    this.search,
  }) : super(endpoint: endpoint, title: title);

  PalettesEntry.fromJson(Map<String, dynamic> json)
      : search = getSearchIfAny(json),
        super.fromJson(json);

  final PalettesSearchEntry? search;

  static PalettesSearchEntry? getSearchIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) => PalettesSearchEntry.fromJson(childMap),
      );
}
