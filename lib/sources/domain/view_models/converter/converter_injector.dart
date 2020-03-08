import 'dart:async';

import 'package:colored/sources/presentation/pages/converter_page.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:colored/sources/presentation/layouts/converter_layout.dart';

class ConverterInjector {
  static ConverterPage injectConverter() => ConverterPage(
    viewModel: ConverterViewModel(
        stateController: StreamController<ConverterState>()),
    child: ConverterLayout(),
  );
}