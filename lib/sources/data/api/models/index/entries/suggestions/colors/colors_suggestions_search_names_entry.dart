import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class ColorsSuggestionsSearchNamesEntry extends ApiIndexEntry {
  const ColorsSuggestionsSearchNamesEntry({
    required String title,
    Uri? endpoint,
  }) : super(title: title, endpoint: endpoint);

  ColorsSuggestionsSearchNamesEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
