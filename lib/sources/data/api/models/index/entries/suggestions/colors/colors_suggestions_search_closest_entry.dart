import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class ColorsSuggestionsSearchClosestEntry extends ApiIndexEntry {
  const ColorsSuggestionsSearchClosestEntry({
    required Uri? endpoint,
    required String title,
  }) : super(title: title, endpoint: endpoint);

  ColorsSuggestionsSearchClosestEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
