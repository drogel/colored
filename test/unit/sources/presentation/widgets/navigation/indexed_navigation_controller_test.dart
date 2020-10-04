import 'dart:async';

import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  IndexedNavigationController viewModel;
  StreamController<IndexedNavigationState> stateController;

  setUp(() {
    stateController = StreamController<IndexedNavigationState>();
    viewModel = IndexedNavigationController(stateController: stateController);
  });

  tearDown(() {
    stateController.close();
    stateController = null;
    viewModel = null;
  });

  group("Given a IndexedNavigationController", () {
    group("when constructed", () {
      test("then should throw if given null stateController", () {
        expect(
          () => IndexedNavigationController(stateController: null),
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
        expect(actual.currentIndex, 0);
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
        const testIndex = 1;
        stateController.stream.listen((event) {
          expect(event.currentIndex, testIndex);
        });
        viewModel.navigateToIndex(testIndex);
      });
    });
  });
}
