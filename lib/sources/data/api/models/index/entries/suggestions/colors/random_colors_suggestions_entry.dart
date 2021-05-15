import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class RandomColorsSuggestionsEntry implements ApiIndexEntry {
  const RandomColorsSuggestionsEntry({
    required this.endpoint,
    required this.title,
  });

  @override
  final Uri endpoint;

  @override
  final String title;
}
