import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_search_names_entry.dart';

class PalettesSearchEntry extends ApiIndexEntry {
  const PalettesSearchEntry({
    required String title,
    Uri? endpoint,
    this.names,
  }) : super(title: title, endpoint: endpoint);

  PalettesSearchEntry.fromJson(Map<String, dynamic> json)
      : names = getNamesIfAny(json),
        super.fromJson(json);

  final PalettesSearchNamesEntry? names;

  static PalettesSearchNamesEntry? getNamesIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) => PalettesSearchNamesEntry.fromJson(childMap),
      );
}
