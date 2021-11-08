import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_color_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

class ColorNamesServiceStub implements NamesService<String> {
  static const mockColorNames = {
    "212121": "Sample Color",
    "212122": "Sample Color 2",
    "212123": "Sample Color 3",
    "212124": "Sample Color 4",
  };

  @override
  Future<Map<String, String>> fetchContainingSearch(
    String searchString,
  ) async =>
      mockColorNames;
}

void main() {
  late NamesService<String> namesService;
  late Paginator<NamedColor> paginator;
  late PaginatedNamesService<NamedColor> paginatedNamesService;

  setUp(() {
    namesService = ColorNamesServiceStub();
    paginator = const ListPaginator();
    paginatedNamesService = PaginatedColorNamesService(
      namesService: namesService,
      paginator: paginator,
    );
  });

  group("Given a $PaginatedColorNamesService with a mocked data source", () {
    group("when fetchContainingSearch is called", () {
      test("then the colors in the first page can be found", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 0,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "2121",
          pageInfo: testPageInfo,
        );
		if (actual == null) {
			fail("Did not expect $ListPage to be null.");
		}
        expect(actual.pageIndex, 0);
        expect(actual.currentItemCount, 2);
        expect(actual.itemsPerPage, 2);
        expect(actual.totalPages, 2);
        expect(actual.items, const [
          NamedColor(hex: "#212121", name: "Sample Color"),
          NamedColor(hex: "#212122", name: "Sample Color 2"),
        ]);
      });

      test("then the colors in the second page can be found", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 1,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "2121",
          pageInfo: testPageInfo,
        );
		if (actual == null) {
			fail("Did not expect $ListPage to be null.");
		}
        expect(actual.pageIndex, 1);
        expect(actual.currentItemCount, 2);
        expect(actual.itemsPerPage, 2);
        expect(actual.totalPages, 2);
        expect(actual.items, const [
          NamedColor(hex: "#212123", name: "Sample Color 3"),
          NamedColor(hex: "#212124", name: "Sample Color 4"),
        ]);
      });

      test("then an empty page is retrieved if pageIndex is too big", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 2,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "2121",
          pageInfo: testPageInfo,
        );
		if (actual == null) {
			fail("Did not expect $ListPage to be null.");
		}
        expect(actual.pageIndex, 2);
        expect(actual.currentItemCount, 0);
        expect(actual.itemsPerPage, 2);
        expect(actual.totalPages, 2);
        expect(actual.items, const []);
      });
    });
  });
}
