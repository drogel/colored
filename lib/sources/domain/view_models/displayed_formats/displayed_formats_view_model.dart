import 'dart:async';

import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/common/extensions/list_swap.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DisplayedFormatsViewModel {
  DisplayedFormatsViewModel({
    @required StreamController<DisplayedFormatsState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<DisplayedFormatsState> _stateController;

  List<Format> _displayedFormats = List<Format>.from(Format.values);

  Stream<DisplayedFormatsState> get stateStream => _stateController.stream;

  DisplayedFormatsState get initialState =>
      DisplayedFormatsState(_displayedFormats);

  void updateDisplayedFormats(Format selected, Format previous) {
    final previousIndex = _displayedFormats.indexOf(previous);
    final newDisplayedFormats = List<Format>.from(_displayedFormats);

    if (_displayedFormats.contains(selected)) {
      final selectedIndex = newDisplayedFormats.indexOf(selected);
      newDisplayedFormats.swap(selectedIndex, previousIndex);
    }

    _stateController.sink.add(DisplayedFormatsState(newDisplayedFormats));
    _displayedFormats = newDisplayedFormats;
  }

  void dispose() => _stateController.close();
}
