import 'package:colored/sources/data/api/services/suggestions/suggestions_search_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

const testPageInfo = PageInfo(startIndex: 1, size: 3, pageIndex: 1);

class PaginatedNamesServiceStub implements PaginatedNamesService<NamedColor> {
  const PaginatedNamesServiceStub();

  static const stubbedNamedColors = <NamedColor>[
    NamedColor(name: "Black", hex: "#000000"),
    NamedColor(name: "White", hex: "#FFFFFF"),
  ];

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      ListPage.singlePageFromItems(stubbedNamedColors);
}

void main() {
  late SuggestionsSearchApiService service;
  late PaginatedNamesServiceStub stubbedService;

  group("Given a $SuggestionsSearchApiService with a stubbed service", () {
    setUp(() {
      stubbedService = const PaginatedNamesServiceStub();
      service = SuggestionsSearchApiService(
        namesService: stubbedService,
      );
    });

    group("when fetchContainingSearch is called", () {
      group("with a short searchString", () {
        test("then a null $ListPage is retrieved", () async {
          final listPage = await service.fetchContainingSearch(
            "t",
            pageInfo: testPageInfo,
          );
          expect(listPage, isNull);
        });

        test("then the last $ListPage is retrieved", () async {
          final firstPage = await service.fetchContainingSearch(
            "testing",
            pageInfo: testPageInfo,
          );
          final listPage = await service.fetchContainingSearch(
            "t",
            pageInfo: testPageInfo,
          );
          expect(listPage, firstPage);
        });
      });

      group("with a long searchString", () {
        test("then a non-null $ListPage is retrieved", () async {
          final listPage = await service.fetchContainingSearch(
            "testing",
            pageInfo: testPageInfo,
          );
          if (listPage == null) {
            fail("Expected a non-null $ListPage.");
          }
          expect(listPage.items, PaginatedNamesServiceStub.stubbedNamedColors);
        });

        test("then the last $ListPage is retrieved", () async {
          final firstPage = await service.fetchContainingSearch(
            "testing",
            pageInfo: testPageInfo,
          );
          final listPage = await service.fetchContainingSearch(
            "testing",
            pageInfo: testPageInfo,
          );
          expect(listPage, firstPage);
        });
      });
    });
  });
}
