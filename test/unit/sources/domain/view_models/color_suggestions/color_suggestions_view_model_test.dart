import 'dart:async';

import 'package:colored/sources/data/services/suggestions/suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class SuggestionsServiceStub implements SuggestionsService {
  static const mockSuggestions = {"1": "First", "2": "Second"};

  @override
  Future<Map<String, dynamic>> fetchSuggestions(int estimatedCount) async =>
      mockSuggestions;
}

class SuggestionsServiceEmptyStub implements SuggestionsService {
  @override
  Future<Map<String, dynamic>> fetchSuggestions(int estimatedCount) async => {};
}

void main() {
  ColorSuggestionsViewModel viewModel;
  SuggestionsService suggestionsService;
  StreamController<ColorSuggestionsState> stateController;

  group("Given a ColorSuggestionsViewModel with a stubbed service", () {
    setUp(() {
      stateController = StreamController<ColorSuggestionsState>();
      suggestionsService = SuggestionsServiceStub();
      viewModel = ColorSuggestionsViewModel(
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

    group("when init is called", () {
      test("then ColorSuggestionsFound state is retrieved", () async {
        stateController.stream.listen((event) {
          expect(event.runtimeType, ColorSuggestionsFound);
        });
        await viewModel.init();
      });

      test("then the expected NamedColor list is retrieved", () async {
        const expected = [
          NamedColor(name: "First", hex: "#1"),
          NamedColor(name: "Second", hex: "#2"),
        ];
        stateController.stream.listen((event) {
          final actualSuggestionsState = event as ColorSuggestionsFound;
          final actual = actualSuggestionsState.colorSuggestions;
          expect(actual, expected);
        });
        await viewModel.init();
      });
    });
  });

  group("Given a ColorSuggestionsViewModel with an empty service", () {
    setUp(() {
      stateController = StreamController<ColorSuggestionsState>();
      suggestionsService = SuggestionsServiceEmptyStub();
      viewModel = ColorSuggestionsViewModel(
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
