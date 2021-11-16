import 'dart:async';

import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/suggestions/paginated_suggestions_service.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class SuggestionsServiceStub implements PaginatedSuggestionsService<Palette> {
  static const mockSuggestions = [
    Palette(name: "First", hexCodes: ["#000000", "#FFFFFF"]),
    Palette(name: "Second", hexCodes: []),
  ];

  @override
  Future<ListPage<Palette>?> fetchRandom({
    required PageInfo pageInfo,
  }) async =>
      ListPage.singlePageFromItems(mockSuggestions);
}

class SuggestionsServiceEmptyStub
    implements PaginatedSuggestionsService<Palette> {
  @override
  Future<ListPage<Palette>?> fetchRandom({
    required PageInfo pageInfo,
  }) async =>
      null;
}

void main() {
  late PaletteSuggestionsViewModel viewModel;
  late PaginatedSuggestionsService<Palette> suggestionsService;
  late StreamController<PaletteSuggestionsState> stateController;

  group("Given a PaletteSuggestionsViewModel", () {
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
        test("then PaletteSuggestionsViewModel state is retrieved", () async {
          stateController.stream.listen((event) {
            expect(event, isA<PaletteSuggestionsFound>());
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
  });
}
