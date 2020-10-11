import 'dart:async';

import 'package:colored/sources/domain/view_models/converter/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ConverterInjector injector;

  setUp(() {
    injector = const ConverterInjector();
  });

  tearDown(() {
    injector = null;
  });

  group("Given an ConverterInjector", () {
    group("when injectViewModel is called", () {
      test("then the provided stateController is given to the viewModel", () {
        final stateController = StreamController<ConverterState>();

        final viewModel = injector.injectViewModel(stateController);

        expect(viewModel.stateStream, stateController.stream);
      });

      test("a default stateController is provided if none is passed", () {
        final viewModel = injector.injectViewModel();

        expect(viewModel.stateStream, isNotNull);
      });
    });
  });
}