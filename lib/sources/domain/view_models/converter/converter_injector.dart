import 'dart:async';

import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';

class ConverterInjector {
  const ConverterInjector();

  ConverterViewModel injectViewModel() => ConverterViewModel(
        stateController: StreamController<ConverterState>(),
      );
}
