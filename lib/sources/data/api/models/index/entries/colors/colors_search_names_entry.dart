import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class ColorsSearchNamesEntry extends ApiIndexEntry {
  const ColorsSearchNamesEntry({required String title, Uri? endpoint})
      : super(title: title, endpoint: endpoint);

  ColorsSearchNamesEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
