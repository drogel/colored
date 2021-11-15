import 'package:colored/sources/data/services/suggestions/local_paginated_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';

class NamedColorsPaginatedSuggestionsService
    extends LocalPaginatedSuggestionsService<String, NamedColor> {
  const NamedColorsPaginatedSuggestionsService({
    required SuggestionsService<String> suggestionsService,
  }) : super(suggestionsService: suggestionsService);

  @override
  NamedColor convertEntry(MapEntry<String, String> entry) =>
      NamedColor.fromMapEntry(entry);
}
