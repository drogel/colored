import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/palettes_suggestions_search_names_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/random_palettes_suggestions_entry.dart';

class PalettesSuggestionsEntry extends ApiIndexEntry {
  const PalettesSuggestionsEntry({
    required String title,
    Uri? endpoint,
    this.random,
    this.names,
  }) : super(title: title, endpoint: endpoint);

  PalettesSuggestionsEntry.fromJson(Map<String, dynamic> json)
      : random = getRandomIfAny(json),
        names = getNamesIfAny(json),
        super.fromJson(json);

  final RandomPalettesSuggestionsEntry? random;
  final PalettesSuggestionsSearchNamesEntry? names;

  static RandomPalettesSuggestionsEntry? getRandomIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) =>
            RandomPalettesSuggestionsEntry.fromJson(childMap),
      );

  static PalettesSuggestionsSearchNamesEntry? getNamesIfAny(
    Map<String, dynamic> json,
  ) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        1,
        json: json,
        entryBuilder: (childMap) =>
            PalettesSuggestionsSearchNamesEntry.fromJson(childMap),
      );
}
