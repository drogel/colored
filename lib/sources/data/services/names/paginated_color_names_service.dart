import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/base_paginated_names_service.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';

class PaginatedColorNamesService
    extends BasePaginatedNamesService<NamedColor, String> {
  const PaginatedColorNamesService({
    required NamesService<String> namesService,
    required Paginator<NamedColor> paginator,
  }) : super(
          namesService: namesService,
          paginator: paginator,
          mapper: _convertToNamedColor,
        );

  static NamedColor _convertToNamedColor(MapEntry<String, dynamic> entry) =>
      NamedColor.fromMapEntry(entry);
}
