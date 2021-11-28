import 'dart:async';

import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/list_paginator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/data/services/names/paginated_color_names_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/search/color_suggestions_search_view_model.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
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

class NamesServiceNullStub implements PaginatedNamesService<NamedColor> {
  const NamesServiceNullStub();

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      null;
}

const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

const testCurrentNamedColors = [
  NamedColor(name: "gray", hex: "#111111"),
  NamedColor(name: "red", hex: "#FF0000"),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ColorSuggestionsSearchViewModel viewModel;
  late StreamController<NamesListState> stateController;
  late NamesService<String> namesService;

  setUp(() {
    stateController = StreamController<NamesListState>();
    namesService = MockNamesService();
    viewModel = ColorSuggestionsSearchViewModel(
      stateController: stateController,
      namesService: PaginatedColorNamesService(
        namesService: namesService,
        paginator: const ListPaginator(),
      ),
    );
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a $ColorSuggestionsSearchViewModel", () {
    group("when initialState is called", () {
      test("then a Starting state is received", () {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Starting>());
      });
    });

    group("when clearSearch is called", () {
      test("then a Starting state is received", () {
        stateController.stream.listen(
          (event) => expect(event, isA<Starting>()),
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

  group("Given a $ColorSuggestionsSearchViewModel with stubs", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceStub();
      viewModel = ColorSuggestionsSearchViewModel(
        stateController: stateController,
        namesService: PaginatedColorNamesService(
          namesService: namesService,
          paginator: const ListPaginator(),
        ),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when searchNextPage is called", () {
      test("then a Pending state is not added", () async {
        await viewModel.searchNextPage(
          "se",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then a Found state is added after the first Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<Found>()),
            );
        viewModel.searchNextPage(
          "red",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      test("then the search from the Pending state is retrieved", () {
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

      test("then the search from the Found state is retrieved", () {
        const expected = "search";
        stateController.stream.skip(1).listen(
              (event) => expect(event.search, expected),
            );
        viewModel.searchNextPage(
          expected,
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      group("namedColors are retrieved", () {
        test("containing the first namedColor from the current colors", () {
          stateController.stream.skip(1).listen((event) {
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
          stateController.stream.skip(1).listen((event) {
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
      test("then a Pending state is not added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then Found state is added after the Starting state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<Found>()),
            );
        viewModel.startSearch("red");
      });

      test("then the search from the Starting state is retrieved", () {
        const expected = "se";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.startSearch(expected);
      });

      test("then the search from the Found state is retrieved", () {
        const expected = "search";
        stateController.stream.skip(1).listen(
              (event) => expect(event.search, expected),
            );
        viewModel.startSearch(expected);
      });

      test("then namedColors are retrieved", () {
        stateController.stream.skip(1).listen((event) {
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

  group("Given a $ColorSuggestionsSearchViewModel with empty NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceEmptyStub();
      viewModel = ColorSuggestionsSearchViewModel(
        stateController: stateController,
        namesService: PaginatedColorNamesService(
          namesService: namesService,
          paginator: const ListPaginator(),
        ),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("then a Pending state is added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("then Pending is not added", () async {
        await viewModel.searchNextPage(
          "se",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then Found is retrieved after the Pending is added", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<Found>()),
            );
        viewModel.searchNextPage(
          "red",
          currentItems: testCurrentNamedColors,
          currentPageInfo: testPageInfo,
        );
      });

      test("then namedColors found are the currentItems", () {
        stateController.stream.skip(1).listen((event) {
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

  group("Given a $ColorSuggestionsSearchViewModel with an stubs", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      viewModel = ColorSuggestionsSearchViewModel(
        stateController: stateController,
        namesService: const NamesServiceNullStub(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when startSearch is called", () {
      test("then a Pending state is not added", () async {
        await viewModel.startSearch("se");
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.startSearch("red");
      });
    });

    group("when searchNextPage is called", () {
      test("then a Pending state is not added", () async {
        await viewModel.searchNextPage(
          "red",
          currentPageInfo: testPageInfo,
          currentItems: testCurrentNamedColors,
        );
        expect(await viewModel.stateStream.first, isNot(isA<Pending>()));
      });

      test("then NoneFound is retrieved after the Pending state", () {
        stateController.stream.skip(1).listen(
              (event) => expect(event, isA<NoneFound>()),
            );
        viewModel.searchNextPage(
          "red",
          currentPageInfo: testPageInfo,
          currentItems: testCurrentNamedColors,
        );
      });
    });
  });
}
