import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/colors/colors_suggestions_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/palettes/palettes_suggestions_entry.dart';

class SuggestionsEntry extends ApiIndexEntry {
  const SuggestionsEntry({
    required String title,
    required Uri? endpoint,
    this.colors,
    this.palettes,
  }) : super(title: title, endpoint: endpoint);

  SuggestionsEntry.fromJson(Map<String, dynamic> json)
      : colors = getColorsIfAny(json),
        palettes = getPalettesIfAny(json),
        super.fromJson(json);

  final ColorsSuggestionsEntry? colors;
  final PalettesSuggestionsEntry? palettes;

  static ColorsSuggestionsEntry? getColorsIfAny(Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        0,
        json: json,
        entryBuilder: (childMap) => ColorsSuggestionsEntry.fromJson(childMap),
      );

  static PalettesSuggestionsEntry? getPalettesIfAny(
          Map<String, dynamic> json) =>
      ApiIndexEntry.getChildEntryAtIndexIfAny(
        1,
        json: json,
        entryBuilder: (childMap) => PalettesSuggestionsEntry.fromJson(childMap),
      );
}
