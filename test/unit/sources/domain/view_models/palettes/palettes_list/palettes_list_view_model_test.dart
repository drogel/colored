import 'dart:async';

import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_palette_names_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNamesService extends Mock implements NamesService<List<String>> {}

class PalettesServiceStub implements NamesService<List<String>> {
  static const testPaletteName = "test";
  static const black = "000000";
  static const white = "ffffff";
  static const palettesMap = {
    testPaletteName: [black, white],
    "$testPaletteName 1": ["$black 1", "$white 1"],
    "$testPaletteName 2": ["$black 2", "$white 2"]
  };

  @override
  Future<Map<String, List<String>>> fetchContainingSearch(
          String searchString) async =>
      palettesMap;
}

class PalettesServiceEmptyStub implements NamesService<List<String>> {
  @override
  Future<Map<String, List<String>>> fetchContainingSearch(
          String searchString) async =>
      {};
}

class PalettesServiceNullStub implements PaginatedNamesService<Palette> {
  const PalettesServiceNullStub();

  @override
  Future<ListPage<Palette>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      null;
}

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testCurrentPalettes = [
  Palette(name: "reds", hexCodes: ["#FF0000", "#FF0001"]),
  Palette(name: "blues", hexCodes: ["#0000FF", "#0000FE"]),
];

void main() {
  late PalettesListViewModel viewModel;
  late NamesService<List<String>> namesService;
  late StreamController<NamesListState> stateController;

  setUp(() {
    stateController = StreamController<NamesListState>();
    namesService = MockNamesService();
    viewModel = PalettesListViewModel(
      stateController: stateController,
      namesService: PaginatedPaletteNamesService(
        namesService: namesService,
        paginator: const ListPaginator(),
      ),
    );
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a $PalettesListViewModel", () {
    group("when initialState is called", () {
      test("then a Starting state is received", () {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Starting>());
      });
    });

    group("When clearSearch is called", () {
      test("then a Starting state is received", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Starting>()),
        );
        viewModel.clearSearch();
      });
    });

    group("When dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });
  });

  group("Given a $PalettesListViewModel with a stubbed PalettesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = PalettesServiceStub();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: PaginatedPaletteNamesService(
          namesService: namesService,
          paginator: const ListPaginator(),
        ),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when searchNextPage is called", () {
      test("then a Pending state is retrieved", () async {
        const shortSearch = "te";
        await viewModel.searchNextPage(
          shortSearch,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
        final event = await viewModel.stateStream.first;
        expect(event, isA<Pending>());
        expect(event.search, shortSearch);
      });

      test("then a Found state is retrieved after Pending", () {
        const validSearch = "testing";
        stateController.stream.skip(1).listen((event) {
          expect(event, isA<Found>());
        });

        viewModel.searchNextPage(
          validSearch,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });

      test("then palettes are retrieved after the Pending state", () {
        const validSearch = "testing";
        final expected = testCurrentPalettes +
            [
              const Palette(
                name: "test 1",
                hexCodes: ["#000000 1", "#FFFFFF 1"],
              )
            ];

        stateController.stream.skip(1).listen((event) {
          final foundState = event as Found;
          expect(foundState.palettes, expected);
        });

        viewModel.searchNextPage(
          validSearch,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });
    });

    group("when startSearch is called", () {
      test("then Pending is added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isA<Pending>());
      });

      test("then Found state is added after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => (event) => expect(event, isA<Found>()),
            );
        viewModel.startSearch("red");
      });

      test("then the search is retrieved from the Pending state", () async {
        const expected = "se";
        await viewModel.startSearch(expected);
        final event = await viewModel.stateStream.first;
        expect(event.search, expected);
      });

      test("then search is retrieved", () {
        const expected = "search";
        stateController.stream.skip(1).listen(
              (event) => (event) => expect(event.search, expected),
            );
        viewModel.startSearch(expected);
      });

      test("then palettes are retrieved", () {
        stateController.stream.skip(1).listen((event) {
          final found = event as Found;
          final expected = Palette(
            name: PalettesServiceStub.palettesMap.keys.first,
            hexCodes: ["#000000", "#FFFFFF"],
          );
          final actual = found.palettes.first;
          expect(actual, expected);
        });
        viewModel.startSearch("red");
      });
    });
  });

  group("Given a $PalettesListViewModel with an empty PalettesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = PalettesServiceEmptyStub();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: PaginatedPaletteNamesService(
          namesService: namesService,
          paginator: const ListPaginator(),
        ),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("then Pending is added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isA<Pending>());
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("with a valid searchString then current palettes are retrieved", () {
        const searchString = "test";

        stateController.stream.skip(1).listen((event) {
          expect(event, isA<Found>());
          final foundState = event as Found;
          expect(event.search, searchString);
          expect(foundState.palettes, testCurrentPalettes);
        });

        viewModel.searchNextPage(
          searchString,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });

      test("then a Pending state is retrieved", () async {
        const shortString = "te";

        await viewModel.searchNextPage(
          shortString,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );

        final event = await viewModel.stateStream.first;
        expect(event, isA<Pending>());
        expect(event.search, shortString);
      });
    });
  });

  group("Given a $PalettesListViewModel with an stubbed NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: const PalettesServiceNullStub(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("then Pending is added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isA<Pending>());
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("then Pending is added", () async {
        await viewModel.searchNextPage(
          "se",
          currentPageInfo: testPageInfo,
          currentItems: testCurrentPalettes,
        );
        expect(await viewModel.stateStream.first, isA<Pending>());
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.searchNextPage(
          "red",
          currentPageInfo: testPageInfo,
          currentItems: testCurrentPalettes,
        );
      });
    });
  });
}
