import 'dart:async';

import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_color_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/base/names/names_list_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNamesService extends Mock implements NamesService<String> {}

class NamesServiceStub implements NamesService<String> {
  static const Map<String, String> namesMap = {
    "testHex": "testName",
    "000000": "000000",
    "000001": "000001",
    "000002": "000002",
  };

  @override
  Future<Map<String, String>> fetchContainingSearch(
          String searchString) async =>
      namesMap;
}

class NamesServiceEmptyStub implements NamesService<String> {
  @override
  Future<Map<String, String>> fetchContainingSearch(
          String searchString) async =>
      {};
}

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testCurrentNamedColors = [
  NamedColor(name: "gray", hex: "#111111"),
  NamedColor(name: "red", hex: "#FF0000"),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late NamesListViewModel viewModel;
  late StreamController<NamesListState> stateController;
  late NamesService<String> namesService;

  setUp(() {
    stateController = StreamController<NamesListState>();
    namesService = MockNamesService();
    viewModel = NamesListViewModel(
      stateController: stateController,
      namesService: PaginatedColorNamesService(
        namesService: namesService,
        paginator: const ListPaginator(),
      ),
      searchConfigurator: const ListSearchConfigurator(),
    );
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a NamesListViewModel", () {
    group("when initialState is called", () {
      test("then a Pending state is received", () {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Pending>());
      });
    });

    group("when clearSearch is called", () {
      test("then a Pending state is received", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
        );
        viewModel.clearSearch();
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when stateStream is called", () {
      test("the stream of the provided state controller is retrieved", () {
        expect(viewModel.stateStream, stateController.stream);
      });
    });
  });

  group("Given a NamesListViewModel with an stubbed NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceStub();
      viewModel = NamesListViewModel(
        stateController: stateController,
        namesService: PaginatedColorNamesService(
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
      test("with a searchString of length < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
        );
        viewModel.searchNextPage(
          "se",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      test("with a searchString of length >= 3, then Found state is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Found>()),
        );
        viewModel.searchNextPage(
          "red",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      test("with a searchString of length < 3, then search is retrieved", () {
        const expected = "se";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.searchNextPage(
          expected,
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      test("with a searchString of length >= 3, then search is retrieved", () {
        const expected = "search";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.searchNextPage(
          expected,
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      group("with searchString.length >= 3, namedColors are retrieved", () {
        test("containing the first namedColor from the current colors", () {
          stateController.stream.listen((event) {
            final found = event as Found;
            final expected = NamedColor(
              name: testCurrentNamedColors.first.name,
              hex: testCurrentNamedColors.first.hex,
            );
            final actual = found.namedColors.first;
            expect(actual, expected);
          });
          viewModel.searchNextPage(
            "red",
            currentItems: testCurrentNamedColors,
            currentPageInfo: testPageInfo,
          );
        });

        test("containing the first namedColor from the retrieved colors", () {
          stateController.stream.listen((event) {
            final found = event as Found;
            const namesMap = NamesServiceStub.namesMap;
            final expected = NamedColor(
              name: namesMap.values.toList()[1],
              hex: "#${namesMap.keys.toList()[1].toUpperCase()}",
            );
            final actual = found.namedColors[testCurrentNamedColors.length];
            expect(actual, expected);
          });
          viewModel.searchNextPage(
            "red",
            currentItems: testCurrentNamedColors,
            currentPageInfo: testPageInfo,
          );
        });
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

      test("with searchString.length >= 3, then namedColors are retrieved", () {
        stateController.stream.listen((event) {
          final found = event as Found;
          final expected = NamedColor(
            name: NamesServiceStub.namesMap.values.first,
            hex: "#${NamesServiceStub.namesMap.keys.first.toUpperCase()}",
          );
          final actual = found.namedColors.first;
          expect(actual, expected);
        });
        viewModel.startSearch("red");
      });
    });
  });

  group("Given a NamesListViewModel with an empty NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceEmptyStub();
      viewModel = NamesListViewModel(
        stateController: stateController,
        namesService: PaginatedColorNamesService(
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
      test("with a searchString of length < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Pending>()),
        );
        viewModel.searchNextPage(
          "se",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      group("with searchString.length >= 3", () {
        test("then Found is retrieved", () {
          stateController.stream.listen(
            (event) => expect(event, isA<Found>()),
          );
          viewModel.searchNextPage(
            "red",
            currentItems: testCurrentNamedColors,
            currentPageInfo: testPageInfo,
          );
        });

        test("then namedColors found are the currentItems", () {
          stateController.stream.listen((event) {
            final found = event as Found;
            expect(found.namedColors, testCurrentNamedColors);
          });
          viewModel.searchNextPage(
            "red",
            currentItems: testCurrentNamedColors,
            currentPageInfo: testPageInfo,
          );
        });
      });
    });
  });
}
