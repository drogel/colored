import 'dart:async';

import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
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
      searchConfigurator: const ListSearchConfigurator(),
    );
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a $PalettesListViewModel", () {
    group("when initialState is called", () {
      test("then a Pending state is received", () {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Pending>());
      });
    });

    group("When clearSearch is called", () {
      test("then a Pending state is received", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
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
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when searchNextPage is called", () {
      test("then a Pending state is retrieved if searchString is short", () {
        const shortSearch = "te";
        viewModel.stateStream.listen((event) {
          expect(event, isA<Pending>());
          expect(event.search, shortSearch);
        });

        viewModel.searchNextPage(
          shortSearch,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });

      test("then a Found state is retrieved for a valid searchString", () {
        const validSearch = "testing";
        viewModel.stateStream.listen((event) {
          expect(event, isA<Found>());
        });

        viewModel.searchNextPage(
          validSearch,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });

      test("then palettes are retrieved for a valid searchString", () {
        const validSearch = "testing";
        final expected = testCurrentPalettes +
            [
              const Palette(
                name: "test 1",
                hexCodes: ["#000000 1", "#FFFFFF 1"],
              )
            ];

        viewModel.stateStream.listen((event) {
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
      test("with a searchString of length < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
        );
        viewModel.startSearch("se");
      });

      test("with a searchString of length >= 3, then Found state is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Found>()),
        );
        viewModel.startSearch("red");
      });

      test("with a searchString of length < 3, then search is retrieved", () {
        const expected = "se";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.startSearch(expected);
      });

      test("with a searchString of length >= 3, then search is retrieved", () {
        const expected = "search";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.startSearch(expected);
      });

      test("with searchString.length >= 3, then palettes are retrieved", () {
        stateController.stream.listen((event) {
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
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("with a searchString of length < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
        );
        viewModel.startSearch("se");
      });

      test("with searchString.length >= 3, then NoneFound is retrieved", () {
        stateController.stream.listen(
          (event) => expect(event, isA<NoneFound>()),
        );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("with a valid searchString then current palettes are retrieved", () {
        const searchString = "test";

        viewModel.stateStream.listen((event) {
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

      test("with a short searchString then a Pending state is retrieved", () {
        const shortString = "te";

        viewModel.stateStream.listen((event) {
          expect(event, isA<Pending>());
          expect(event.search, shortString);
        });

        viewModel.searchNextPage(
          shortString,
          currentItems: testCurrentPalettes,
          currentPageInfo: testPageInfo,
        );
      });
    });
  });

  group("Given a $PalettesListViewModel with an stubbed NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: const PalettesServiceNullStub(),
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("then NoneFound is retrieved", () {
        stateController.stream.listen(
          (event) => expect(event, isA<NoneFound>()),
        );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("then NoneFound is retrieved", () {
        stateController.stream.listen(
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
