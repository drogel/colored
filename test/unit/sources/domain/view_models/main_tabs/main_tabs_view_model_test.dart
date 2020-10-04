import 'dart:async';

import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_view_model.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MainTabsViewModel viewModel;
  StreamController<IndexedNavigationState> stateController;

  setUp(() {
    stateController = StreamController<IndexedNavigationState>();
    viewModel = MainTabsViewModel(stateController: stateController);
  });

  tearDown(() {
    stateController.close();
    stateController = null;
    viewModel = null;
  });

  group("Given a MainTabsViewController", () {
    group("when constructed", () {
      test("then should throw if given null stateController", () {
        expect(
          () => MainTabsViewModel(stateController: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when initialState is called", () {
      test("then a state with currentIndex of 0 is retrieved", () {
        final actual = viewModel.initialState;
        expect(actual.currentIndex, MainTabsSelection.converter.index);
      });
    });

    group("when stateStream is called", () {
      test("then the stream from the stateController is retrieved", () {
        final actual = viewModel.stateStream;
        expect(actual, stateController.stream);
      });
    });

    group("when navigateToIndex is called", () {
      test("then a new state with the passed index is added to the stream", () {
        const testSelection = MainTabsSelection.converter;
        stateController.stream.listen((event) {
          expect(event.currentIndex, testSelection.index);
        });
        viewModel.navigateToIndex(testSelection.index);
      });
    });
  });
}
