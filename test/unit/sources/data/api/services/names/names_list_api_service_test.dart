import 'package:colored/sources/data/api/services/names/names_list_api_service.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

class NamesListApiServiceCountStub
    implements PaginatedNamesService<NamedColor> {
  NamesListApiServiceCountStub();

  int callCount = 0;

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async {
    callCount++;
    return ListPage.singlePageFromItems([]);
  }
}

const _kTestPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

void main() {
  late NamesListApiServiceCountStub namesService;
  late NamesListApiServiceCountStub hexesService;
  late NamesListApiService namesListApiService;

  group("Given a $NamesListApiService", () {
    setUp(() {
      namesService = NamesListApiServiceCountStub();
      hexesService = NamesListApiServiceCountStub();
      namesListApiService = NamesListApiService(
        colorNamesApiService: namesService,
        colorHexesApiService: hexesService,
      );
    });

    group("when fetchContainingSearch with a non-hex search", () {
      test("then the namesService handles the call", () {
        namesListApiService.fetchContainingSearch(
          "nonHex",
          pageInfo: _kTestPageInfo,
        );
        expect(namesService.callCount, 1);
        expect(hexesService.callCount, 0);
      });
    });

    group("when fetchContainingSearch with a hex search", () {
      test("then the hexesService handles the call", () {
        namesListApiService.fetchContainingSearch(
          "#000000",
          pageInfo: _kTestPageInfo,
        );
        expect(namesService.callCount, 0);
        expect(hexesService.callCount, 1);
      });

      test("then the hexesService handles the call", () {
        namesListApiService.fetchContainingSearch(
          "000000",
          pageInfo: _kTestPageInfo,
        );
        expect(namesService.callCount, 0);
        expect(hexesService.callCount, 1);
      });
    });
  });
}
