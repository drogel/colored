import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';

class PalettesSearchNamesEntry extends ApiIndexEntry {
  const PalettesSearchNamesEntry({
    required Uri? endpoint,
    required String title,
  }) : super(title: title, endpoint: endpoint);

  PalettesSearchNamesEntry.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}
