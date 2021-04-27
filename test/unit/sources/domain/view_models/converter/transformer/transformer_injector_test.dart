import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/domain/view_models/converter/transformer/transformer_injector.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TransformerInjector injector;

  setUp(() {
    injector = const TransformerInjector(
      initialColor: Color.fromRGBO(0, 0, 0, 1),
    );
  });

  group("Given a TransformerInjector with a black initial color", () {
    group("when injectViewModel is called", () {
      test("then a StreamController is given by default if not specified", () {
        final viewModel = injector.injectViewModel();
        expect(viewModel.stateStream, isNotNull);
      });

      test("then a StreamController<TransformerState> can be provided", () {
        final stateController = StreamController<TransformerState>();
        final viewModel = injector.injectViewModel(stateController);
        expect(viewModel.stateStream, stateController.stream);
      });
    });
  });
}
