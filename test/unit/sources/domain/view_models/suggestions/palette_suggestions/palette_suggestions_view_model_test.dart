import 'dart:async';

import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/suggestions/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/suggestions/palette_suggestions/palette_suggestions_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class SuggestionsServiceStub implements SuggestionsService<List<String>> {
  static const mockSuggestions = <String, List<String>>{
    "First": ["000000", "ffffff"],
    "Second": [],
  };

  @override
  Future<Map<String, List<String>>> fetchSuggestions(
          int estimatedCount) async =>
      mockSuggestions;
}

class SuggestionsServiceEmptyStub implements SuggestionsService<List<String>> {
  @override
  Future<Map<String, List<String>>> fetchSuggestions(
          int estimatedCount) async =>
      {};
}

void main() {
  PaletteSuggestionsViewModel viewModel;
  SuggestionsService<List<String>> suggestionsService;
  StreamController<PaletteSuggestionsState> stateController;

  group("Given a PaletteSuggestionsViewModel", () {
    group("when constructed", () {
      test("then throws an assertion error if stateController is null", () {
        expect(
          () => PaletteSuggestionsViewModel(
            stateController: null,
            suggestionsService: SuggestionsServiceStub(),
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then throws an assertion error if suggestionsSerice is null", () {
        expect(
          () => PaletteSuggestionsViewModel(
            stateController: StreamController<PaletteSuggestionsState>(),
            suggestionsService: null,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });

  group("Given a PaletteSuggestionsViewModel with a stubbed service", () {
    setUp(() {
      stateController = StreamController<PaletteSuggestionsState>();
      suggestionsService = SuggestionsServiceStub();
      viewModel = PaletteSuggestionsViewModel(
        stateController: stateController,
        suggestionsService: suggestionsService,
      );
    });

    tearDown(() {
      stateController.close();
      viewModel = null;
      suggestionsService = null;
      stateController = null;
    });

    group("when initialState is called", () {
      test("then a Loading state is received", () {
        final actual = viewModel.initialState;
        expect(actual.runtimeType, Loading);
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

    group("when init is called", () {
      test("then PaletteSuggestionsViewModel state is retrieved", () async {
        stateController.stream.listen((event) {
          expect(event.runtimeType, PaletteSuggestionsFound);
        });
        await viewModel.init();
      });

      test("then the expected NamedColor list is retrieved", () async {
        const expected = [
          Palette(name: "First", hexCodes: ["#000000", "#FFFFFF"]),
          Palette(name: "Second", hexCodes: []),
        ];
        stateController.stream.listen((event) {
          final actualSuggestionsState = event as PaletteSuggestionsFound;
          final actual = actualSuggestionsState.paletteSuggestions;
          expect(actual, expected);
        });
        await viewModel.init();
      });
    });
  });

  group("Given a PaletteSuggestionsViewModel with an empty service", () {
    setUp(() {
      stateController = StreamController<PaletteSuggestionsState>();
      suggestionsService = SuggestionsServiceEmptyStub();
      viewModel = PaletteSuggestionsViewModel(
        stateController: stateController,
        suggestionsService: suggestionsService,
      );
    });

    tearDown(() {
      stateController.close();
      viewModel = null;
      suggestionsService = null;
      stateController = null;
    });

    group("when init is called", () {
      test("then Failed state is retrieved", () async {
        stateController.stream.listen((event) {
          expect(event.runtimeType, Failed);
        });
        await viewModel.init();
      });
    });
  });
}
