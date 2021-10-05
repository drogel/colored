import 'package:colored/sources/common/extensions/list_safe_element_at_index.dart';
import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/colors/colors_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/palettes/palettes_entry.dart';
import 'package:colored/sources/data/api/models/index/entries/suggestions/suggestions_entry.dart';

class ApiIndex extends ApiIndexEntry {
  const ApiIndex(
    this.colors,
    this.palettes,
    this.suggestions,
  ) : super(title: "/", endpoint: null);

  factory ApiIndex.fromJsonEntries(List<Map<String, dynamic>> jsonEntries) {
    final colorsEntry = jsonEntries.safeElementAt(0);
    final palettesEntry = jsonEntries.safeElementAt(1);
    final suggestionsEntry = jsonEntries.safeElementAt(2);
    final colors =
        colorsEntry != null ? ColorsEntry.fromJson(colorsEntry) : null;
    final palettes =
        palettesEntry != null ? PalettesEntry.fromJson(palettesEntry) : null;
    final suggestions = suggestionsEntry != null
        ? SuggestionsEntry.fromJson(suggestionsEntry)
        : null;
    return ApiIndex(colors, palettes, suggestions);
  }

  final ColorsEntry? colors;
  final PalettesEntry? palettes;
  final SuggestionsEntry? suggestions;
}
