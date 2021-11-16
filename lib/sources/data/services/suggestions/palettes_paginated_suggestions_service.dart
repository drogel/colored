import 'package:colored/sources/data/services/suggestions/local_paginated_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';

class PalettesPaginatedSuggestionsService
    extends LocalPaginatedSuggestionsService<List<String>, Palette> {
  const PalettesPaginatedSuggestionsService({
    required SuggestionsService<List<String>> suggestionsService,
  }) : super(suggestionsService: suggestionsService);

  @override
  Palette convertEntry(MapEntry<String, List<String>> entry) =>
      Palette.fromMapEntry(entry);
}
