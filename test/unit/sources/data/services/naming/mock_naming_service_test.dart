import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/data/services/naming/mock_naming_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PaginatedNamesService<NamedColor> namingService;

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    namingService = const MockNamingService();
  });

  group("Given a MockNamingService", () {
    group("when fetchNaming is called for any hexColor", () {
      test("then expected sample color is retrieved", () async {
        final actualPage = await namingService.fetchContainingSearch(
          "",
          pageInfo: const PageInfo(startIndex: 1, size: 1, pageIndex: 1),
        );
        const expectedPage = ListPage<NamedColor>(
          currentItemCount: 1,
          itemsPerPage: 1,
          startIndex: 1,
          totalItems: 1,
          pageIndex: 1,
          totalPages: 1,
          items: [NamedColor(name: "Sample Color", hex: "#212121")],
        );
        expect(actualPage, expectedPage);
      });
    });
  });
}
