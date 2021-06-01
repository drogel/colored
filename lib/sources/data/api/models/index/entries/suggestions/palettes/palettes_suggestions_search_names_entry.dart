import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class PalettesSuggestionsSearchNamesEntry extends ApiIndexEntry {
  const PalettesSuggestionsSearchNamesEntry({
    required String title,
    Uri? endpoint,
  }) : super(title: title, endpoint: endpoint);

  PalettesSuggestionsSearchNamesEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
