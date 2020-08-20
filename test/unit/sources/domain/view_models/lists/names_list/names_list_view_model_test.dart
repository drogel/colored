import 'dart:async';

import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/lists/base/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/lists/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/lists/names_list/names_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNamesService extends Mock implements NamesService {}

class NamesServiceStub implements NamesService {
  static const Map<String, String> namesMap = {"testHex": "testName"};

  @override
  Future<Map<String, String>> fetchContainingSearch(
          String searchString) async =>
      namesMap;
}

class NamesServiceEmptyStub implements NamesService {
  @override
  Future<Map<String, String>> fetchContainingSearch(
          String searchString) async =>
      {};
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  NamesListViewModel viewModel;
  StreamController<NamesListState> stateController;
  NamesService namesService;

  setUp(() {
    stateController = StreamController<NamesListState>();
    namesService = MockNamesService();
    viewModel = NamesListViewModel(
      stateController: stateController,
      namesService: namesService,
      searchConfigurator: const ListSearchConfigurator(),
    );
  });

  tearDown(() {
    if (stateController != null) {
      stateController.close();
    }
    stateController = null;
    namesService = null;
  });

  group("Given a NamesListViewModel", () {
    group("When initialState is called", () {
      test("then a Pending state is received", () {
        final initialState = viewModel.initialState;
        expect(initialState.runtimeType, Pending);
      });
    });

    group("When clearSearch is called", () {
      test("then a Pending state is received", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Pending),
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

    group("when constructed", () {
      test("then stateController must not be null", () {
        expect(
          () => NamesListViewModel(
            stateController: null,
            namesService: namesService,
            searchConfigurator: const ListSearchConfigurator(),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then namesService must not be null", () {
        expect(
          () => NamesListViewModel(
            stateController: stateController,
            namesService: null,
            searchConfigurator: const ListSearchConfigurator(),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then stateController must not be null", () {
        expect(
          () => NamesListViewModel(
            stateController: stateController,
            namesService: namesService,
            searchConfigurator: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });

  group("Given a NamesListViewModel with an stubbed NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceStub();
      viewModel = NamesListViewModel(
        stateController: stateController,
        namesService: namesService,
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namesService = null;
    });

    group("when searchColorName is called", () {
      test("with a searchString of lenght < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Pending),
        );
        viewModel.searchColorName("se");
      });

      test("with a searchString of lenght >= 3, then Found state is added", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Found),
        );
        viewModel.searchColorName("red");
      });

      test("with a searchString of lenght < 3, then search is retrieved", () {
        const expected = "se";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.searchColorName(expected);
      });

      test("with a searchString of lenght >= 3, then search is retrieved", () {
        const expected = "search";
        stateController.stream.listen(
          (event) => expect(event.search, expected),
        );
        viewModel.searchColorName(expected);
      });

      test("with searchString.lenght >= 3, then namedColors are retrieved", () {
        stateController.stream.listen((event) {
          final found = event as Found;
          final expected = NamedColor(
            name: NamesServiceStub.namesMap.values.first,
            hex: "#${NamesServiceStub.namesMap.keys.first.toUpperCase()}",
          );
          final actual = found.namedColors.first;
          expect(actual, expected);
        });
        viewModel.searchColorName("red");
      });
    });
  });

  group("Given a NamesListViewModel with an empty NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceEmptyStub();
      viewModel = NamesListViewModel(
        stateController: stateController,
        namesService: namesService,
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namesService = null;
    });

    group("when searchColorName is called", () {
      test("with a searchString of lenght < 3, then Pending is added", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Pending),
        );
        viewModel.searchColorName("se");
      });

      test("with searchString.lenght >= 3, then NoneFound is retrieved", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, NoneFound),
        );
        viewModel.searchColorName("red");
      });
    });
  });
}
