import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class RandomPalettesSuggestionsEntry extends ApiIndexEntry {
  const RandomPalettesSuggestionsEntry({
    required String title,
    Uri? endpoint,
  }) : super(title: title, endpoint: endpoint);

  RandomPalettesSuggestionsEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
