import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class RandomColorsSuggestionsEntry extends ApiIndexEntry {
  const RandomColorsSuggestionsEntry({
    required String title,
    Uri? endpoint,
  }) : super(title: title, endpoint: endpoint);

  RandomColorsSuggestionsEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
