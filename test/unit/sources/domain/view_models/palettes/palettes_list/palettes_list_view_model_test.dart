import 'dart:async';

import 'package:colored/sources/common/search_configurator/list_search_configurator.dart';
import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
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
    testPaletteName: [black, white]
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

void main() {
  late PalettesListViewModel viewModel;
  late NamesService<List<String>> namesService;
  late StreamController<PalettesListState> stateController;

  setUp(() {
    stateController = StreamController<PalettesListState>();
    namesService = MockNamesService();
    viewModel = PalettesListViewModel(
      stateController: stateController,
      namesService: namesService,
      searchConfigurator: const ListSearchConfigurator(),
    );
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a PalettesListViewModel", () {
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

  group("Given a PalettesViewModel with a stubbed PalettesService", () {
    setUp(() {
      stateController = StreamController<PalettesListState>();
      namesService = PalettesServiceStub();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: namesService,
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when searchPalettes is called", () {
      test("then a Pending state is retrieved if searchString is short", () {
        const shortSearch = "te";
        viewModel.stateStream.listen((event) {
          expect(event, isA<Pending>());
          expect(event.search, shortSearch);
        });

        viewModel.searchPalettes(shortSearch);
      });

      test("then a Found state is retrieved for a valid searchString", () {
        const validSearch = "testing";
        viewModel.stateStream.listen((event) {
          expect(event, isA<Found>());
        });

        viewModel.searchPalettes(validSearch);
      });

      test("then palettes are retrieved for a valid searchString", () {
        const validSearch = "testing";
        const expected = [
          Palette(
            name: PalettesServiceStub.testPaletteName,
            hexCodes: ["#000000", "#FFFFFF"],
          )
        ];

        viewModel.stateStream.listen((event) {
          final foundState = event as Found;
          expect(foundState.palettes, expected);
        });

        viewModel.searchPalettes(validSearch);
      });
    });
  });

  group("Given a PalettesViewModel with an empty PalettesService", () {
    setUp(() {
      stateController = StreamController<PalettesListState>();
      namesService = PalettesServiceEmptyStub();
      viewModel = PalettesListViewModel(
        stateController: stateController,
        namesService: namesService,
        searchConfigurator: const ListSearchConfigurator(),
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when searchPalettes is called", () {
      test("with a valid searchString then a NoneFound is retrieved", () {
        const searchString = "test";

        viewModel.stateStream.listen((event) {
          expect(event, isA<NoneFound>());
          expect(event.search, searchString);
        });

        viewModel.searchPalettes(searchString);
      });

      test("with a short searchString then a Pending state is retrieved", () {
        const shortString = "te";

        viewModel.stateStream.listen((event) {
          expect(event, isA<Pending>());
          expect(event.search, shortString);
        });

        viewModel.searchPalettes(shortString);
      });
    });
  });
}
