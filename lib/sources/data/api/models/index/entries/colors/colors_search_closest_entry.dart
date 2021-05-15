import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class ColorsSearchClosestEntry extends ApiIndexEntry {
  const ColorsSearchClosestEntry({required Uri endpoint, required String title})
      : super(endpoint: endpoint, title: title);

  ColorsSearchClosestEntry.fromJson(Map<String, String> json)
      : super.fromJson(json);
}
