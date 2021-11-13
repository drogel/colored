import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/base_paginated_names_service.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';

class PaginatedPaletteNamesService
    extends BasePaginatedNamesService<Palette, List<String>> {
  const PaginatedPaletteNamesService({
    required NamesService<List<String>> namesService,
    required Paginator<Palette> paginator,
  }) : super(
          namesService: namesService,
          paginator: paginator,
          mapper: _convertToPalette,
        );

  static Palette _convertToPalette(MapEntry<String, List<String>> entry) =>
      Palette.fromMapEntry(entry);
}
