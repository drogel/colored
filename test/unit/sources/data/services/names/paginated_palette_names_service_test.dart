import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/pagination/paginator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_palette_names_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';

class PaletteNamesServiceStub implements NamesService<List<String>> {
  static const mockPaletteNames = {
    "Sample Color": ["000000", "ffffff"],
    "Sample Color 2": ["000001", "ffffff"],
    "Sample Color 3": ["000002", "ffffff"],
    "Sample Color 4": ["000003", "ffffff"],
  };

  @override
  Future<Map<String, List<String>>> fetchContainingSearch(
    String searchString,
  ) async =>
      mockPaletteNames;
}

void main() {
  late NamesService<List<String>> namesService;
  late Paginator<Palette> paginator;
  late PaginatedNamesService<Palette> paginatedNamesService;

  setUp(() {
    namesService = PaletteNamesServiceStub();
    paginator = const ListPaginator();
    paginatedNamesService = PaginatedPaletteNamesService(
      namesService: namesService,
      paginator: paginator,
    );
  });

  group("Given a $PaginatedPaletteNamesService with a mocked data source", () {
    group("when fetchContainingSearch is called", () {
      test("then the palettes in the first page can be found", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 0,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "Sample",
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
          Palette(name: "Sample Color", hexCodes: ["#000000", "#FFFFFF"]),
          Palette(name: "Sample Color 2", hexCodes: ["#000001", "#FFFFFF"]),
        ]);
      });

      test("then the palettes in the second page can be found", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 1,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "Sample",
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
          Palette(name: "Sample Color 3", hexCodes: ["#000002", "#FFFFFF"]),
          Palette(name: "Sample Color 4", hexCodes: ["#000003", "#FFFFFF"]),
        ]);
      });

      test("then an empty page is retrieved if pageIndex is too big", () async {
        const testPageInfo = PageInfo(
          startIndex: 0,
          size: 2,
          pageIndex: 2,
        );
        final actual = await paginatedNamesService.fetchContainingSearch(
          "Sample",
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
