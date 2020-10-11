import 'dart:async';

import 'package:colored/sources/domain/view_models/converter/picker/picker_state.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_view_model.dart';

class PickerInjector {
  const PickerInjector();

  PickerViewModel injectViewModel([
    StreamController<PickerState> stateController,
  ]) =>
      PickerViewModel(
        stateController: stateController ?? StreamController<PickerState>(),
      );
}
