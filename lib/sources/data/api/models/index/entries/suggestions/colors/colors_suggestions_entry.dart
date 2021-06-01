import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_search_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/random_colors_suggestions_entry.dart';

class ColorsSuggestionsEntry extends ApiIndexEntry {
  const ColorsSuggestionsEntry({
    required String title,
    Uri? endpoint,
    this.random,
    this.search,
  }) : super(title: title, endpoint: endpoint);

  ColorsSuggestionsEntry.fromJson(Map<String, dynamic> json)
      : random = getRandomIfAny(json),
        search = getSearchIfAny(json),
        super.fromJson(json);

  final RandomColorsSuggestionsEntry? random;
  final ColorsSuggestionsSearchEntry? search;

  static RandomColorsSuggestionsEntry? getRandomIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) =>
            RandomColorsSuggestionsEntry.fromJson(childMap),
      );

  static ColorsSuggestionsSearchEntry? getSearchIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        1,
        json: json,
        entryBuilder: (childMap) =>
            ColorsSuggestionsSearchEntry.fromJson(childMap),
      );
}
