import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/data_loader/data_loader.dart';
import 'package:colored/sources/data/services/list_picker/string_list_picker.dart';
import 'package:colored/sources/data/services/suggestions/cherry_picked_suggestions_service.dart';
import 'package:colored/sources/data/services/suggestions/named_colors_paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';

import 'suggestions_service_test_helper.dart';

void main() {
  group("Given a $NamedColorsPaginatedSuggestionsService", () {
    late NamedColorsPaginatedSuggestionsService suggestionsService;
    late DataLoader<String> suggestionsDataLoader;

    setUp(() {
      suggestionsDataLoader = ColorSuggestionsLoaderStub();
      suggestionsService = NamedColorsPaginatedSuggestionsService(
        suggestionsService: CherryPickedSuggestionsService<String>(
          dataLoader: suggestionsDataLoader,
          listPicker: StringListPicker(
            intGenerator: RandomGeneratorStub(),
          ),
        ),
      );
    });

    group("when fetchRandom is called", () {
      test("then the expected $NamedColor list is retrieved", () async {
        const pageInfo = PageInfo(startIndex: 1, size: 2, pageIndex: 1);
        final actual = await suggestionsService.fetchRandom(pageInfo: pageInfo);
        const expected = [
          NamedColor(name: "Second", hex: "#222222"),
          NamedColor(name: "Fourth", hex: "#444444"),
        ];
        final actualPage = actual;
        if (actualPage == null) {
          fail("Expected a non-null $ListPage");
        }
        expect(actualPage.items, expected);
        expect(actualPage.currentItemCount, 2);
        expect(actualPage.itemsPerPage, 2);
      });
    });
  });
}
