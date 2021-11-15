import 'dart:async';

import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/color_suggestions_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class SuggestionsServiceStub
    implements PaginatedSuggestionsService<NamedColor> {
  static const mockSuggestions = [
    NamedColor(name: "First", hex: "#1"),
    NamedColor(name: "Second", hex: "#2"),
  ];

  @override
  Future<ListPage<NamedColor>?> fetchRandom({
    required PageInfo pageInfo,
  }) async =>
      ListPage(
        currentItemCount: mockSuggestions.length,
        itemsPerPage: mockSuggestions.length,
        startIndex: 1,
        totalItems: mockSuggestions.length,
        pageIndex: 1,
        totalPages: 1,
        items: mockSuggestions,
      );
}

class SuggestionsServiceEmptyStub
    implements PaginatedSuggestionsService<NamedColor> {
  @override
  Future<ListPage<NamedColor>?> fetchRandom({
    required PageInfo pageInfo,
  }) async =>
      null;
}

void main() {
  late ColorSuggestionsViewModel viewModel;
  late PaginatedSuggestionsService<NamedColor> suggestionsService;
  late StreamController<ColorSuggestionsState> stateController;

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
    });

    group("when initialState is called", () {
      test("then a Loading state is received", () {
        final actual = viewModel.initialState;
        expect(actual, isA<Loading>());
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
      test("then ColorSuggestionsFound state is retrieved", () async {
        stateController.stream.listen((event) {
          expect(event, isA<ColorSuggestionsFound>());
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
    });

    group("when init is called", () {
      test("then Failed state is retrieved", () async {
        stateController.stream.listen((event) {
          expect(event, isA<Failed>());
        });
        await viewModel.init();
      });
    });
  });
}
