import 'dart:async';

import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/view_models/lists/base/list_search_configurator.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNamesService extends Mock implements NamesService {}

void main() {
  PalettesListViewModel viewModel;
  NamesService namesService;
  StreamController<PalettesListState> stateController;

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
    if (stateController != null) {
      stateController.close();
    }
    stateController = null;
    namesService = null;
  });

  group("Given a PalettesListViewModel", () {
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
          () => PalettesListViewModel(
            stateController: null,
            namesService: namesService,
            searchConfigurator: const ListSearchConfigurator(),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then namesService must not be null", () {
        expect(
          () => PalettesListViewModel(
            stateController: stateController,
            namesService: null,
            searchConfigurator: const ListSearchConfigurator(),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then stateController must not be null", () {
        expect(
          () => PalettesListViewModel(
            stateController: stateController,
            namesService: namesService,
            searchConfigurator: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}
