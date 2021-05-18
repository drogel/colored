import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_hexes_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_names_entry.dart';

class ColorsSuggestionsSearchEntry extends ApiIndexEntry {
  const ColorsSuggestionsSearchEntry({
    required String title,
    Uri? endpoint,
    this.hexes,
    this.names,
  }) : super(title: title, endpoint: endpoint);

  ColorsSuggestionsSearchEntry.fromJson(Map<String, dynamic> json)
      : hexes = getHexesIfAny(json),
        names = getNamesIfAny(json),
        super.fromJson(json);

  final ColorsSuggestionsSearchHexesEntry? hexes;
  final ColorsSuggestionsSearchNamesEntry? names;

  static ColorsSuggestionsSearchHexesEntry? getHexesIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) =>
            ColorsSuggestionsSearchHexesEntry.fromJson(childMap),
      );

  static ColorsSuggestionsSearchNamesEntry? getNamesIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        1,
        json: json,
        entryBuilder: (childMap) =>
            ColorsSuggestionsSearchNamesEntry.fromJson(childMap),
      );
}
