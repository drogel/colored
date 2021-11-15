import 'dart:convert';

import 'package:colored/resources/mock_data_paths.dart' as mock_paths;
import 'package:colored/sources/data/api/services/base/request/api_request_builder.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter/services.dart';

class MockPaletteNamingService implements ApiRequestBuilder<NamedColor> {
  const MockPaletteNamingService();

  @override
  Future<ListPage<NamedColor>?> request(
    Iterable<String> queryParameters, {
    required PageInfo pageInfo,
  }) async {
    final samplePalette = await rootBundle.loadString(mock_paths.samplePalette);
    final jsonResponse = jsonDecode(samplePalette);
    final mapList = jsonResponse[NamedColor.mocksMappingKey];
    final paletteMap = List<Map<String, dynamic>>.from(mapList);
    final namedColors = paletteMap.map((m) => NamedColor.fromJson(m)).toList();
    return ListPage<NamedColor>(
      currentItemCount: namedColors.length,
      itemsPerPage: namedColors.length,
      startIndex: 1,
      totalItems: namedColors.length,
      pageIndex: 1,
      totalPages: 1,
      items: namedColors,
    );
  }
}
