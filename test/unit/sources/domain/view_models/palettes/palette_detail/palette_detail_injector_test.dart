import 'dart:async';

import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PaletteDetailInjector injector;

  setUp(() {
    injector = const PaletteDetailInjector();
  });

  tearDown(() {
    injector = null;
  });

  group("Given a PaletteDetailInjector", () {
    group("when injectViewModel is called", () {
      test("then a StreamController is given by default if not specified", () {
        final viewModel = injector.injectViewModel();
        expect(viewModel.stateStream, isNotNull);
      });

      test("then a StreamController<TransformerState> can be provided", () {
        final stateController = StreamController<PaletteDetailState>();
        final viewModel = injector.injectViewModel(stateController);
        expect(viewModel.stateStream, stateController.stream);
      });
    });
  });
}
