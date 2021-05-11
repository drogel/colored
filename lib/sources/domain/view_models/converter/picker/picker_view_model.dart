import 'dart:async';

import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_state.dart';

class PickerViewModel {
  const PickerViewModel({
    required StreamController<PickerState> stateController,
  }) : _stateController = stateController;

  final StreamController<PickerState> _stateController;

  Stream<PickerState> get stateStream => _stateController.stream;

  PickerState get initialState => const PickerState(PickerStyle.rgb);

  void updatePickerStyle(int pickerStyleIndex) {
    if (pickerStyleIndex < 0 || pickerStyleIndex >= PickerStyle.values.length) {
      return;
    }

    final newPickerStyle = PickerStyle.values[pickerStyleIndex];
    _stateController.sink.add(PickerState(newPickerStyle));
  }

  void dispose() => _stateController.close();
}
