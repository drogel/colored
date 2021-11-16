import 'dart:convert';

import 'package:colored/resources/mock_data_paths.dart' as mock_paths;
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter/services.dart';

class MockNamingService implements PaginatedNamesService<NamedColor> {
  const MockNamingService();

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    final sampleColorStr = await rootBundle.loadString(mock_paths.sampleColor);
    final map = jsonDecode(sampleColorStr);
    final namingMap = map[NamedColor.mocksMappingKey].first;
    final namedColor = NamedColor.fromJson(namingMap);
    return ListPage.singlePageFromItems([namedColor]);
  }
}
