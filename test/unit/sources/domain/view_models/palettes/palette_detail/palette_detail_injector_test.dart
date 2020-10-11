import 'dart:async';

import 'package:colored/configuration/flavor.dart';
import 'package:colored/configuration/flavor_values/flavor_values.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFlavor implements Flavor {
  const MockFlavor();

  @override
  bool isDevelopment() => true;

  @override
  bool isProduction() => false;

  @override
  FlavorValues get values => null;
}

void main() {
  PaletteDetailInjector injector;

  setUp(() {
    injector = const PaletteDetailInjector(flavor: MockFlavor());
  });

  tearDown(() {
    injector = null;
  });

  group("Given a PaletteDetailInjector", () {
    group("when constructed", () {
      test("then an assertion error is thrown on null flavor", () {
        expect(() => PaletteDetailInjector(flavor: null), throwsAssertionError);
      });
    });

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
