import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_closest_entry.dart';

class ColorsSuggestionsSearchHexesEntry extends ApiIndexEntry {
  const ColorsSuggestionsSearchHexesEntry({
    required Uri endpoint,
    required String title,
    this.closest,
  }) : super(endpoint: endpoint, title: title);

  ColorsSuggestionsSearchHexesEntry.fromJson(Map<String, dynamic> json)
      : closest = getClosestIfAny(json),
        super.fromJson(json);

  final ColorsSuggestionsSearchClosestEntry? closest;

  static ColorsSuggestionsSearchClosestEntry? getClosestIfAny(
          Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) =>
            ColorsSuggestionsSearchClosestEntry.fromJson(childMap),
      );
}
