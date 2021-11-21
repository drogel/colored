import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/data/color_helpers/transformer/color_transformer.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';

const _kTunedChangeFactor = 2;

class TransformerViewModel {
  const TransformerViewModel({
    required StreamController<TransformerState> stateController,
    required ColorTransformer transformer,
    required Color initialColor,
  })  : _initialColor = initialColor,
        _stateController = stateController,
        _transformer = transformer;

  final StreamController<TransformerState> _stateController;

  final ColorTransformer _transformer;

  final Color _initialColor;

  TransformerState get initialState {
    final initialSelection = ColorSelection.fromColor(_initialColor);
    return TransformerState(initialSelection);
  }

  Stream<TransformerState> get stateStream => _stateController.stream;

  void notifySelectionChanged(ColorSelection selection) =>
      _stateController.sink.add(TransformerState(selection));

  void notifySelectionStarted(ColorSelection selection) =>
      _stateController.sink.add(SelectionStarted(selection));

  void notifySelectionEnded(ColorSelection selection) =>
      _stateController.sink.add(SelectionEnded(selection));

  void rotateColor(double change, ColorSelection current) {
    final selection = _transformer.rotate(current, change);
    _stateController.sink.add(SelectionStarted(selection));
  }

  void changeLightness(double change, ColorSelection current) {
    final tunedChange = change / _kTunedChangeFactor;
    final selection = _transformer.changeLightness(current, tunedChange);
    _stateController.sink.add(SelectionStarted(selection));
  }

  void dispose() => _stateController.close();
}
