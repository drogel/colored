import 'dart:async';

import 'package:colored/sources/domain/inherited/converter/converter_updater.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:colored/sources/presentation/pages/converter.dart';

class ConverterInjector {
  static ConverterUpdater injectConverter() => ConverterUpdater(
    viewModel: ConverterViewModel(
        stateController: StreamController<ConverterState>()),
    child: Converter(),
  );
}